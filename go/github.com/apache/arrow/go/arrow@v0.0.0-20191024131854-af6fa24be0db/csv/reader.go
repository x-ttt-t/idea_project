// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package csv

import (
	"encoding/csv"
	"io"
	"strconv"
	"sync"
	"sync/atomic"

	"github.com/apache/arrow/go/arrow"
	"github.com/apache/arrow/go/arrow/array"
	"github.com/apache/arrow/go/arrow/internal/debug"
	"github.com/apache/arrow/go/arrow/memory"
	"github.com/pkg/errors"
)

// Reader wraps encoding/csv.Reader and creates array.Records from a schema.
type Reader struct {
	r      *csv.Reader
	schema *arrow.Schema

	refs int64
	bld  *array.RecordBuilder
	cur  array.Record
	err  error

	chunk int
	done  bool
	next  func() bool

	mem memory.Allocator

	header bool
	once   sync.Once
}

// NewReader returns a reader that reads from the CSV file and creates
// array.Records from the given schema.
//
// NewReader panics if the given schema contains fields that have types that are not
// primitive types.
func NewReader(r io.Reader, schema *arrow.Schema, opts ...Option) *Reader {
	validate(schema)

	rr := &Reader{r: csv.NewReader(r), schema: schema, refs: 1, chunk: 1}
	rr.r.ReuseRecord = true
	for _, opt := range opts {
		opt(rr)
	}

	if rr.mem == nil {
		rr.mem = memory.DefaultAllocator
	}

	rr.bld = array.NewRecordBuilder(rr.mem, rr.schema)

	switch {
	case rr.chunk < 0:
		rr.next = rr.nextall
	case rr.chunk > 1:
		rr.next = rr.nextn
	default:
		rr.next = rr.next1
	}
	return rr
}

func (r *Reader) readHeader() error {
	records, err := r.r.Read()
	if err != nil {
		return errors.Wrapf(err, "arrow/csv: could not read header from file")
	}

	if len(records) != len(r.schema.Fields()) {
		return ErrMismatchFields
	}

	fields := make([]arrow.Field, len(records))
	for idx, name := range records {
		fields[idx] = r.schema.Field(idx)
		fields[idx].Name = name
	}

	meta := r.schema.Metadata()
	r.schema = arrow.NewSchema(fields, &meta)
	r.bld = array.NewRecordBuilder(r.mem, r.schema)
	return nil
}

// Err returns the last error encountered during the iteration over the
// underlying CSV file.
func (r *Reader) Err() error { return r.err }

func (r *Reader) Schema() *arrow.Schema { return r.schema }

// Record returns the current record that has been extracted from the
// underlying CSV file.
// It is valid until the next call to Next.
func (r *Reader) Record() array.Record { return r.cur }

// Next returns whether a Record could be extracted from the underlying CSV file.
//
// Next panics if the number of records extracted from a CSV row does not match
// the number of fields of the associated schema.
func (r *Reader) Next() bool {
	if r.header {
		r.once.Do(func() {
			r.err = r.readHeader()
		})
	}

	if r.cur != nil {
		r.cur.Release()
		r.cur = nil
	}

	if r.err != nil || r.done {
		return false
	}

	return r.next()
}

// next1 reads one row from the CSV file and creates a single Record
// from that row.
func (r *Reader) next1() bool {
	var recs []string
	recs, r.err = r.r.Read()
	if r.err != nil {
		r.done = true
		if r.err == io.EOF {
			r.err = nil
		}
		return false
	}

	r.validate(recs)
	r.read(recs)
	r.cur = r.bld.NewRecord()

	return true
}

// nextall reads the whole CSV file into memory and creates one single
// Record from all the CSV rows.
func (r *Reader) nextall() bool {
	defer func() {
		r.done = true
	}()

	var (
		recs [][]string
	)

	recs, r.err = r.r.ReadAll()
	if r.err != nil {
		return false
	}

	for _, rec := range recs {
		r.validate(rec)
		r.read(rec)
	}
	r.cur = r.bld.NewRecord()

	return true
}

// nextn reads n rows from the CSV file, where n is the chunk size, and creates
// a Record from these rows.
func (r *Reader) nextn() bool {
	var (
		recs []string
		n    = 0
	)

	for i := 0; i < r.chunk && !r.done; i++ {
		recs, r.err = r.r.Read()
		if r.err != nil {
			r.done = true
			break
		}

		r.validate(recs)
		r.read(recs)
		n++
	}

	if r.err != nil {
		r.done = true
		if r.err == io.EOF {
			r.err = nil
		}
	}

	r.cur = r.bld.NewRecord()
	return n > 0
}

func (r *Reader) validate(recs []string) {
	if r.err != nil {
		return
	}

	if len(recs) != len(r.schema.Fields()) {
		r.err = ErrMismatchFields
		return
	}
}

func (r *Reader) read(recs []string) {
	for i, str := range recs {
		switch r.schema.Field(i).Type.(type) {
		case *arrow.BooleanType:
			var v bool
			switch str {
			case "false", "False", "0":
				v = false
			case "true", "True", "1":
				v = true
			}
			r.bld.Field(i).(*array.BooleanBuilder).Append(v)
		case *arrow.Int8Type:
			v := r.readI8(str)
			r.bld.Field(i).(*array.Int8Builder).Append(v)
		case *arrow.Int16Type:
			v := r.readI16(str)
			r.bld.Field(i).(*array.Int16Builder).Append(v)
		case *arrow.Int32Type:
			v := r.readI32(str)
			r.bld.Field(i).(*array.Int32Builder).Append(v)
		case *arrow.Int64Type:
			v := r.readI64(str)
			r.bld.Field(i).(*array.Int64Builder).Append(v)
		case *arrow.Uint8Type:
			v := r.readU8(str)
			r.bld.Field(i).(*array.Uint8Builder).Append(v)
		case *arrow.Uint16Type:
			v := r.readU16(str)
			r.bld.Field(i).(*array.Uint16Builder).Append(v)
		case *arrow.Uint32Type:
			v := r.readU32(str)
			r.bld.Field(i).(*array.Uint32Builder).Append(v)
		case *arrow.Uint64Type:
			v := r.readU64(str)
			r.bld.Field(i).(*array.Uint64Builder).Append(v)
		case *arrow.Float32Type:
			v := r.readF32(str)
			r.bld.Field(i).(*array.Float32Builder).Append(v)
		case *arrow.Float64Type:
			v := r.readF64(str)
			r.bld.Field(i).(*array.Float64Builder).Append(v)
		case *arrow.StringType:
			r.bld.Field(i).(*array.StringBuilder).Append(str)
		}
	}
}

func (r *Reader) readI8(str string) int8 {
	v, err := strconv.ParseInt(str, 10, 8)
	if err != nil && r.err == nil {
		r.err = err
		return 0
	}
	return int8(v)
}

func (r *Reader) readI16(str string) int16 {
	v, err := strconv.ParseInt(str, 10, 16)
	if err != nil && r.err == nil {
		r.err = err
		return 0
	}
	return int16(v)
}

func (r *Reader) readI32(str string) int32 {
	v, err := strconv.ParseInt(str, 10, 32)
	if err != nil && r.err == nil {
		r.err = err
		return 0
	}
	return int32(v)
}

func (r *Reader) readI64(str string) int64 {
	v, err := strconv.ParseInt(str, 10, 64)
	if err != nil && r.err == nil {
		r.err = err
		return 0
	}
	return int64(v)
}

func (r *Reader) readU8(str string) uint8 {
	v, err := strconv.ParseUint(str, 10, 8)
	if err != nil && r.err == nil {
		r.err = err
		return 0
	}
	return uint8(v)
}

func (r *Reader) readU16(str string) uint16 {
	v, err := strconv.ParseUint(str, 10, 16)
	if err != nil && r.err == nil {
		r.err = err
		return 0
	}
	return uint16(v)
}

func (r *Reader) readU32(str string) uint32 {
	v, err := strconv.ParseUint(str, 10, 32)
	if err != nil && r.err == nil {
		r.err = err
		return 0
	}
	return uint32(v)
}

func (r *Reader) readU64(str string) uint64 {
	v, err := strconv.ParseUint(str, 10, 64)
	if err != nil && r.err == nil {
		r.err = err
		return 0
	}
	return uint64(v)
}

func (r *Reader) readF32(str string) float32 {
	v, err := strconv.ParseFloat(str, 32)
	if err != nil && r.err == nil {
		r.err = err
		return 0
	}
	return float32(v)
}

func (r *Reader) readF64(str string) float64 {
	v, err := strconv.ParseFloat(str, 64)
	if err != nil && r.err == nil {
		r.err = err
		return 0
	}
	return float64(v)
}

// Retain increases the reference count by 1.
// Retain may be called simultaneously from multiple goroutines.
func (r *Reader) Retain() {
	atomic.AddInt64(&r.refs, 1)
}

// Release decreases the reference count by 1.
// When the reference count goes to zero, the memory is freed.
// Release may be called simultaneously from multiple goroutines.
func (r *Reader) Release() {
	debug.Assert(atomic.LoadInt64(&r.refs) > 0, "too many releases")

	if atomic.AddInt64(&r.refs, -1) == 0 {
		if r.cur != nil {
			r.cur.Release()
		}
	}
}

var (
	_ array.RecordReader = (*Reader)(nil)
)
