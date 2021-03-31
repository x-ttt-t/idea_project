// Code generated by the FlatBuffers compiler. DO NOT EDIT.

package fbast

import (
	flatbuffers "github.com/google/flatbuffers/go"
)

type PipeExpression struct {
	_tab flatbuffers.Table
}

func GetRootAsPipeExpression(buf []byte, offset flatbuffers.UOffsetT) *PipeExpression {
	n := flatbuffers.GetUOffsetT(buf[offset:])
	x := &PipeExpression{}
	x.Init(buf, n+offset)
	return x
}

func (rcv *PipeExpression) Init(buf []byte, i flatbuffers.UOffsetT) {
	rcv._tab.Bytes = buf
	rcv._tab.Pos = i
}

func (rcv *PipeExpression) Table() flatbuffers.Table {
	return rcv._tab
}

func (rcv *PipeExpression) BaseNode(obj *BaseNode) *BaseNode {
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

func (rcv *PipeExpression) ArgumentType() byte {
	o := flatbuffers.UOffsetT(rcv._tab.Offset(6))
	if o != 0 {
		return rcv._tab.GetByte(o + rcv._tab.Pos)
	}
	return 0
}

func (rcv *PipeExpression) MutateArgumentType(n byte) bool {
	return rcv._tab.MutateByteSlot(6, n)
}

func (rcv *PipeExpression) Argument(obj *flatbuffers.Table) bool {
	o := flatbuffers.UOffsetT(rcv._tab.Offset(8))
	if o != 0 {
		rcv._tab.Union(obj, o)
		return true
	}
	return false
}

func (rcv *PipeExpression) Call(obj *CallExpression) *CallExpression {
	o := flatbuffers.UOffsetT(rcv._tab.Offset(10))
	if o != 0 {
		x := rcv._tab.Indirect(o + rcv._tab.Pos)
		if obj == nil {
			obj = new(CallExpression)
		}
		obj.Init(rcv._tab.Bytes, x)
		return obj
	}
	return nil
}

func PipeExpressionStart(builder *flatbuffers.Builder) {
	builder.StartObject(4)
}
func PipeExpressionAddBaseNode(builder *flatbuffers.Builder, baseNode flatbuffers.UOffsetT) {
	builder.PrependUOffsetTSlot(0, flatbuffers.UOffsetT(baseNode), 0)
}
func PipeExpressionAddArgumentType(builder *flatbuffers.Builder, argumentType byte) {
	builder.PrependByteSlot(1, argumentType, 0)
}
func PipeExpressionAddArgument(builder *flatbuffers.Builder, argument flatbuffers.UOffsetT) {
	builder.PrependUOffsetTSlot(2, flatbuffers.UOffsetT(argument), 0)
}
func PipeExpressionAddCall(builder *flatbuffers.Builder, call flatbuffers.UOffsetT) {
	builder.PrependUOffsetTSlot(3, flatbuffers.UOffsetT(call), 0)
}
func PipeExpressionEnd(builder *flatbuffers.Builder) flatbuffers.UOffsetT {
	return builder.EndObject()
}
