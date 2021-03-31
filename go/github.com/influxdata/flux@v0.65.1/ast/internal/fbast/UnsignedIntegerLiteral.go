// Code generated by the FlatBuffers compiler. DO NOT EDIT.

package fbast

import (
	flatbuffers "github.com/google/flatbuffers/go"
)

type UnsignedIntegerLiteral struct {
	_tab flatbuffers.Table
}

func GetRootAsUnsignedIntegerLiteral(buf []byte, offset flatbuffers.UOffsetT) *UnsignedIntegerLiteral {
	n := flatbuffers.GetUOffsetT(buf[offset:])
	x := &UnsignedIntegerLiteral{}
	x.Init(buf, n+offset)
	return x
}

func (rcv *UnsignedIntegerLiteral) Init(buf []byte, i flatbuffers.UOffsetT) {
	rcv._tab.Bytes = buf
	rcv._tab.Pos = i
}

func (rcv *UnsignedIntegerLiteral) Table() flatbuffers.Table {
	return rcv._tab
}

func (rcv *UnsignedIntegerLiteral) BaseNode(obj *BaseNode) *BaseNode {
	o := flatbuffers.UOffsetT(rcv._tab.Offset(4))
	if o != 0 {
		x := rcv._tab.Indirect(o + rcv._tab.Pos)
		if obj == nil {
			obj = new(BaseNode)
		}
		obj.Init(rcv._tab.Bytes, x)
		return obj
	}
	return nil
}

func (rcv *UnsignedIntegerLiteral) Value() uint64 {
	o := flatbuffers.UOffsetT(rcv._tab.Offset(6))
	if o != 0 {
		return rcv._tab.GetUint64(o + rcv._tab.Pos)
	}
	return 0
}

func (rcv *UnsignedIntegerLiteral) MutateValue(n uint64) bool {
	return rcv._tab.MutateUint64Slot(6, n)
}

func UnsignedIntegerLiteralStart(builder *flatbuffers.Builder) {
	builder.StartObject(2)
}
func UnsignedIntegerLiteralAddBaseNode(builder *flatbuffers.Builder, baseNode flatbuffers.UOffsetT) {
	builder.PrependUOffsetTSlot(0, flatbuffers.UOffsetT(baseNode), 0)
}
func UnsignedIntegerLiteralAddValue(builder *flatbuffers.Builder, value uint64) {
	builder.PrependUint64Slot(1, value, 0)
}
func UnsignedIntegerLiteralEnd(builder *flatbuffers.Builder) flatbuffers.UOffsetT {
	return builder.EndObject()
}
