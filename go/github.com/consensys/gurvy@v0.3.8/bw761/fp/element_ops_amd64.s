// Copyright 2020 ConsenSys Software Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "textflag.h"
#include "funcdata.h"

// modulus q
DATA q<>+0(SB)/8, $0xf49d00000000008b
DATA q<>+8(SB)/8, $0xe6913e6870000082
DATA q<>+16(SB)/8, $0x160cf8aeeaf0a437
DATA q<>+24(SB)/8, $0x98a116c25667a8f8
DATA q<>+32(SB)/8, $0x71dcd3dc73ebff2e
DATA q<>+40(SB)/8, $0x8689c8ed12f9fd90
DATA q<>+48(SB)/8, $0x03cebaff25b42304
DATA q<>+56(SB)/8, $0x707ba638e584e919
DATA q<>+64(SB)/8, $0x528275ef8087be41
DATA q<>+72(SB)/8, $0xb926186a81d14688
DATA q<>+80(SB)/8, $0xd187c94004faff3e
DATA q<>+88(SB)/8, $0x0122e824fb83ce0a
GLOBL q<>(SB), (RODATA+NOPTR), $96

// qInv0 q'[0]
DATA qInv0<>(SB)/8, $0x0a5593568fa798dd
GLOBL qInv0<>(SB), (RODATA+NOPTR), $8

#define REDUCE_AND_MOVE(ra0, ra1, ra2, ra3, ra4, ra5, ra6, ra7, ra8, ra9, ra10, ra11, rb0, rb1, rb2, rb3, rb4, rb5, rb6, rb7, rb8, rb9, rb10, rb11, res0, res1, res2, res3, res4, res5, res6, res7, res8, res9, res10, res11) \
	MOVQ    ra0, rb0;         \
	MOVQ    ra1, rb1;         \
	MOVQ    ra2, rb2;         \
	MOVQ    ra3, rb3;         \
	MOVQ    ra4, rb4;         \
	MOVQ    ra5, rb5;         \
	MOVQ    ra6, rb6;         \
	MOVQ    ra7, rb7;         \
	MOVQ    ra8, rb8;         \
	MOVQ    ra9, rb9;         \
	MOVQ    ra10, rb10;       \
	MOVQ    ra11, rb11;       \
	SUBQ    q<>(SB), rb0;     \
	SBBQ    q<>+8(SB), rb1;   \
	SBBQ    q<>+16(SB), rb2;  \
	SBBQ    q<>+24(SB), rb3;  \
	SBBQ    q<>+32(SB), rb4;  \
	SBBQ    q<>+40(SB), rb5;  \
	SBBQ    q<>+48(SB), rb6;  \
	SBBQ    q<>+56(SB), rb7;  \
	SBBQ    q<>+64(SB), rb8;  \
	SBBQ    q<>+72(SB), rb9;  \
	SBBQ    q<>+80(SB), rb10; \
	SBBQ    q<>+88(SB), rb11; \
	CMOVQCC rb0, ra0;         \
	CMOVQCC rb1, ra1;         \
	CMOVQCC rb2, ra2;         \
	CMOVQCC rb3, ra3;         \
	CMOVQCC rb4, ra4;         \
	CMOVQCC rb5, ra5;         \
	CMOVQCC rb6, ra6;         \
	CMOVQCC rb7, ra7;         \
	CMOVQCC rb8, ra8;         \
	CMOVQCC rb9, ra9;         \
	CMOVQCC rb10, ra10;       \
	CMOVQCC rb11, ra11;       \
	MOVQ    ra0, res0;        \
	MOVQ    ra1, res1;        \
	MOVQ    ra2, res2;        \
	MOVQ    ra3, res3;        \
	MOVQ    ra4, res4;        \
	MOVQ    ra5, res5;        \
	MOVQ    ra6, res6;        \
	MOVQ    ra7, res7;        \
	MOVQ    ra8, res8;        \
	MOVQ    ra9, res9;        \
	MOVQ    ra10, res10;      \
	MOVQ    ra11, res11;      \

#define REDUCE(ra0, ra1, ra2, ra3, ra4, ra5, ra6, ra7, ra8, ra9, ra10, ra11, rb0, rb1, rb2, rb3, rb4, rb5, rb6, rb7, rb8, rb9, rb10, rb11) \
	MOVQ    ra0, rb0;         \
	MOVQ    ra1, rb1;         \
	MOVQ    ra2, rb2;         \
	MOVQ    ra3, rb3;         \
	MOVQ    ra4, rb4;         \
	MOVQ    ra5, rb5;         \
	MOVQ    ra6, rb6;         \
	MOVQ    ra7, rb7;         \
	MOVQ    ra8, rb8;         \
	MOVQ    ra9, rb9;         \
	MOVQ    ra10, rb10;       \
	MOVQ    ra11, rb11;       \
	SUBQ    q<>(SB), rb0;     \
	SBBQ    q<>+8(SB), rb1;   \
	SBBQ    q<>+16(SB), rb2;  \
	SBBQ    q<>+24(SB), rb3;  \
	SBBQ    q<>+32(SB), rb4;  \
	SBBQ    q<>+40(SB), rb5;  \
	SBBQ    q<>+48(SB), rb6;  \
	SBBQ    q<>+56(SB), rb7;  \
	SBBQ    q<>+64(SB), rb8;  \
	SBBQ    q<>+72(SB), rb9;  \
	SBBQ    q<>+80(SB), rb10; \
	SBBQ    q<>+88(SB), rb11; \
	CMOVQCC rb0, ra0;         \
	CMOVQCC rb1, ra1;         \
	CMOVQCC rb2, ra2;         \
	CMOVQCC rb3, ra3;         \
	CMOVQCC rb4, ra4;         \
	CMOVQCC rb5, ra5;         \
	CMOVQCC rb6, ra6;         \
	CMOVQCC rb7, ra7;         \
	CMOVQCC rb8, ra8;         \
	CMOVQCC rb9, ra9;         \
	CMOVQCC rb10, ra10;       \
	CMOVQCC rb11, ra11;       \

// add(res, x, y *Element)
TEXT ·add(SB), $96-24
	MOVQ    x+8(FP), AX
	MOVQ    0(AX), BX
	MOVQ    8(AX), BP
	MOVQ    16(AX), SI
	MOVQ    24(AX), DI
	MOVQ    32(AX), R8
	MOVQ    40(AX), R9
	MOVQ    48(AX), R10
	MOVQ    56(AX), R11
	MOVQ    64(AX), R12
	MOVQ    72(AX), R13
	MOVQ    80(AX), R14
	MOVQ    88(AX), R15
	MOVQ    y+16(FP), DX
	ADDQ    0(DX), BX
	ADCQ    8(DX), BP
	ADCQ    16(DX), SI
	ADCQ    24(DX), DI
	ADCQ    32(DX), R8
	ADCQ    40(DX), R9
	ADCQ    48(DX), R10
	ADCQ    56(DX), R11
	ADCQ    64(DX), R12
	ADCQ    72(DX), R13
	ADCQ    80(DX), R14
	ADCQ    88(DX), R15
	MOVQ    res+0(FP), CX
	MOVQ    BX, t0-8(SP)
	SUBQ    q<>+0(SB), BX
	MOVQ    BP, t1-16(SP)
	SBBQ    q<>+8(SB), BP
	MOVQ    SI, t2-24(SP)
	SBBQ    q<>+16(SB), SI
	MOVQ    DI, t3-32(SP)
	SBBQ    q<>+24(SB), DI
	MOVQ    R8, t4-40(SP)
	SBBQ    q<>+32(SB), R8
	MOVQ    R9, t5-48(SP)
	SBBQ    q<>+40(SB), R9
	MOVQ    R10, t6-56(SP)
	SBBQ    q<>+48(SB), R10
	MOVQ    R11, t7-64(SP)
	SBBQ    q<>+56(SB), R11
	MOVQ    R12, t8-72(SP)
	SBBQ    q<>+64(SB), R12
	MOVQ    R13, t9-80(SP)
	SBBQ    q<>+72(SB), R13
	MOVQ    R14, t10-88(SP)
	SBBQ    q<>+80(SB), R14
	MOVQ    R15, t11-96(SP)
	SBBQ    q<>+88(SB), R15
	CMOVQCS t0-8(SP), BX
	CMOVQCS t1-16(SP), BP
	CMOVQCS t2-24(SP), SI
	CMOVQCS t3-32(SP), DI
	CMOVQCS t4-40(SP), R8
	CMOVQCS t5-48(SP), R9
	CMOVQCS t6-56(SP), R10
	CMOVQCS t7-64(SP), R11
	CMOVQCS t8-72(SP), R12
	CMOVQCS t9-80(SP), R13
	CMOVQCS t10-88(SP), R14
	CMOVQCS t11-96(SP), R15
	MOVQ    BX, 0(CX)
	MOVQ    BP, 8(CX)
	MOVQ    SI, 16(CX)
	MOVQ    DI, 24(CX)
	MOVQ    R8, 32(CX)
	MOVQ    R9, 40(CX)
	MOVQ    R10, 48(CX)
	MOVQ    R11, 56(CX)
	MOVQ    R12, 64(CX)
	MOVQ    R13, 72(CX)
	MOVQ    R14, 80(CX)
	MOVQ    R15, 88(CX)
	RET

// sub(res, x, y *Element)
TEXT ·sub(SB), NOSPLIT, $0-24
	MOVQ x+8(FP), R13
	MOVQ 0(R13), AX
	MOVQ 8(R13), DX
	MOVQ 16(R13), CX
	MOVQ 24(R13), BX
	MOVQ 32(R13), BP
	MOVQ 40(R13), SI
	MOVQ 48(R13), DI
	MOVQ 56(R13), R8
	MOVQ 64(R13), R9
	MOVQ 72(R13), R10
	MOVQ 80(R13), R11
	MOVQ 88(R13), R12
	MOVQ y+16(FP), R14
	SUBQ 0(R14), AX
	SBBQ 8(R14), DX
	SBBQ 16(R14), CX
	SBBQ 24(R14), BX
	SBBQ 32(R14), BP
	SBBQ 40(R14), SI
	SBBQ 48(R14), DI
	SBBQ 56(R14), R8
	SBBQ 64(R14), R9
	SBBQ 72(R14), R10
	SBBQ 80(R14), R11
	SBBQ 88(R14), R12
	JCC  l1
	ADDQ q<>+0(SB), AX
	ADCQ q<>+8(SB), DX
	ADCQ q<>+16(SB), CX
	ADCQ q<>+24(SB), BX
	ADCQ q<>+32(SB), BP
	ADCQ q<>+40(SB), SI
	ADCQ q<>+48(SB), DI
	ADCQ q<>+56(SB), R8
	ADCQ q<>+64(SB), R9
	ADCQ q<>+72(SB), R10
	ADCQ q<>+80(SB), R11
	ADCQ q<>+88(SB), R12

l1:
	MOVQ res+0(FP), R15
	MOVQ AX, 0(R15)
	MOVQ DX, 8(R15)
	MOVQ CX, 16(R15)
	MOVQ BX, 24(R15)
	MOVQ BP, 32(R15)
	MOVQ SI, 40(R15)
	MOVQ DI, 48(R15)
	MOVQ R8, 56(R15)
	MOVQ R9, 64(R15)
	MOVQ R10, 72(R15)
	MOVQ R11, 80(R15)
	MOVQ R12, 88(R15)
	RET

// double(res, x *Element)
TEXT ·double(SB), $96-16
	MOVQ    res+0(FP), DX
	MOVQ    x+8(FP), AX
	MOVQ    0(AX), CX
	MOVQ    8(AX), BX
	MOVQ    16(AX), BP
	MOVQ    24(AX), SI
	MOVQ    32(AX), DI
	MOVQ    40(AX), R8
	MOVQ    48(AX), R9
	MOVQ    56(AX), R10
	MOVQ    64(AX), R11
	MOVQ    72(AX), R12
	MOVQ    80(AX), R13
	MOVQ    88(AX), R14
	ADDQ    CX, CX
	ADCQ    BX, BX
	ADCQ    BP, BP
	ADCQ    SI, SI
	ADCQ    DI, DI
	ADCQ    R8, R8
	ADCQ    R9, R9
	ADCQ    R10, R10
	ADCQ    R11, R11
	ADCQ    R12, R12
	ADCQ    R13, R13
	ADCQ    R14, R14
	MOVQ    CX, t0-8(SP)
	SUBQ    q<>+0(SB), CX
	MOVQ    BX, t1-16(SP)
	SBBQ    q<>+8(SB), BX
	MOVQ    BP, t2-24(SP)
	SBBQ    q<>+16(SB), BP
	MOVQ    SI, t3-32(SP)
	SBBQ    q<>+24(SB), SI
	MOVQ    DI, t4-40(SP)
	SBBQ    q<>+32(SB), DI
	MOVQ    R8, t5-48(SP)
	SBBQ    q<>+40(SB), R8
	MOVQ    R9, t6-56(SP)
	SBBQ    q<>+48(SB), R9
	MOVQ    R10, t7-64(SP)
	SBBQ    q<>+56(SB), R10
	MOVQ    R11, t8-72(SP)
	SBBQ    q<>+64(SB), R11
	MOVQ    R12, t9-80(SP)
	SBBQ    q<>+72(SB), R12
	MOVQ    R13, t10-88(SP)
	SBBQ    q<>+80(SB), R13
	MOVQ    R14, t11-96(SP)
	SBBQ    q<>+88(SB), R14
	CMOVQCS t0-8(SP), CX
	CMOVQCS t1-16(SP), BX
	CMOVQCS t2-24(SP), BP
	CMOVQCS t3-32(SP), SI
	CMOVQCS t4-40(SP), DI
	CMOVQCS t5-48(SP), R8
	CMOVQCS t6-56(SP), R9
	CMOVQCS t7-64(SP), R10
	CMOVQCS t8-72(SP), R11
	CMOVQCS t9-80(SP), R12
	CMOVQCS t10-88(SP), R13
	CMOVQCS t11-96(SP), R14
	MOVQ    CX, 0(DX)
	MOVQ    BX, 8(DX)
	MOVQ    BP, 16(DX)
	MOVQ    SI, 24(DX)
	MOVQ    DI, 32(DX)
	MOVQ    R8, 40(DX)
	MOVQ    R9, 48(DX)
	MOVQ    R10, 56(DX)
	MOVQ    R11, 64(DX)
	MOVQ    R12, 72(DX)
	MOVQ    R13, 80(DX)
	MOVQ    R14, 88(DX)
	RET

// neg(res, x *Element)
TEXT ·neg(SB), NOSPLIT, $0-16
	MOVQ  res+0(FP), DX
	MOVQ  x+8(FP), AX
	MOVQ  0(AX), BX
	MOVQ  8(AX), BP
	MOVQ  16(AX), SI
	MOVQ  24(AX), DI
	MOVQ  32(AX), R8
	MOVQ  40(AX), R9
	MOVQ  48(AX), R10
	MOVQ  56(AX), R11
	MOVQ  64(AX), R12
	MOVQ  72(AX), R13
	MOVQ  80(AX), R14
	MOVQ  88(AX), R15
	MOVQ  BX, AX
	ORQ   BP, AX
	ORQ   SI, AX
	ORQ   DI, AX
	ORQ   R8, AX
	ORQ   R9, AX
	ORQ   R10, AX
	ORQ   R11, AX
	ORQ   R12, AX
	ORQ   R13, AX
	ORQ   R14, AX
	ORQ   R15, AX
	TESTQ AX, AX
	JEQ   l2
	MOVQ  $0xf49d00000000008b, CX
	SUBQ  BX, CX
	MOVQ  CX, 0(DX)
	MOVQ  $0xe6913e6870000082, CX
	SBBQ  BP, CX
	MOVQ  CX, 8(DX)
	MOVQ  $0x160cf8aeeaf0a437, CX
	SBBQ  SI, CX
	MOVQ  CX, 16(DX)
	MOVQ  $0x98a116c25667a8f8, CX
	SBBQ  DI, CX
	MOVQ  CX, 24(DX)
	MOVQ  $0x71dcd3dc73ebff2e, CX
	SBBQ  R8, CX
	MOVQ  CX, 32(DX)
	MOVQ  $0x8689c8ed12f9fd90, CX
	SBBQ  R9, CX
	MOVQ  CX, 40(DX)
	MOVQ  $0x03cebaff25b42304, CX
	SBBQ  R10, CX
	MOVQ  CX, 48(DX)
	MOVQ  $0x707ba638e584e919, CX
	SBBQ  R11, CX
	MOVQ  CX, 56(DX)
	MOVQ  $0x528275ef8087be41, CX
	SBBQ  R12, CX
	MOVQ  CX, 64(DX)
	MOVQ  $0xb926186a81d14688, CX
	SBBQ  R13, CX
	MOVQ  CX, 72(DX)
	MOVQ  $0xd187c94004faff3e, CX
	SBBQ  R14, CX
	MOVQ  CX, 80(DX)
	MOVQ  $0x0122e824fb83ce0a, CX
	SBBQ  R15, CX
	MOVQ  CX, 88(DX)
	RET

l2:
	MOVQ AX, 0(DX)
	MOVQ AX, 8(DX)
	MOVQ AX, 16(DX)
	MOVQ AX, 24(DX)
	MOVQ AX, 32(DX)
	MOVQ AX, 40(DX)
	MOVQ AX, 48(DX)
	MOVQ AX, 56(DX)
	MOVQ AX, 64(DX)
	MOVQ AX, 72(DX)
	MOVQ AX, 80(DX)
	MOVQ AX, 88(DX)
	RET

// mul(res, x, y *Element)
TEXT ·mul(SB), $96-24

	// the algorithm is described here
	// https://hackmd.io/@zkteam/modular_multiplication
	// however, to benefit from the ADCX and ADOX carry chains
	// we split the inner loops in 2:
	// for i=0 to N-1
	// 		for j=0 to N-1
	// 		    (A,t[j])  := t[j] + x[j]*y[i] + A
	// 		m := t[0]*q'[0] mod W
	// 		C,_ := t[0] + m*q[0]
	// 		for j=1 to N-1
	// 		    (C,t[j-1]) := t[j] + m*q[j] + C
	// 		t[N-1] = C + A

	NO_LOCAL_POINTERS
	CMPB ·supportAdx(SB), $1
	JNE  l3

	// A = R13

	// t[0] = R14
	// t[1] = R15
	// t[2] = CX
	// t[3] = BX
	// t[4] = BP
	// t[5] = SI
	// t[6] = DI
	// t[7] = R8
	// t[8] = R9
	// t[9] = R10
	// t[10] = R11
	// t[11] = R12

	// clear the flags
	XORQ DX, DX
	MOVQ y+16(FP), DX
	MOVQ 0(DX), DX

	// (A,t[0])  := t[0] + x[0]*y[0] + A
	// using A(R13) to store x
	MOVQ  x+8(FP), R13
	MOVQ  0(R13), AX
	MOVQ  AX, x0-8(SP)
	MULXQ AX, R14, R15

	// (A,t[1])  := t[1] + x[1]*y[0] + A
	MOVQ  8(R13), AX
	MOVQ  AX, x1-16(SP)
	MULXQ AX, AX, CX
	ADOXQ AX, R15

	// (A,t[2])  := t[2] + x[2]*y[0] + A
	MOVQ  16(R13), AX
	MOVQ  AX, x2-24(SP)
	MULXQ AX, AX, BX
	ADOXQ AX, CX

	// (A,t[3])  := t[3] + x[3]*y[0] + A
	MOVQ  24(R13), AX
	MOVQ  AX, x3-32(SP)
	MULXQ AX, AX, BP
	ADOXQ AX, BX

	// (A,t[4])  := t[4] + x[4]*y[0] + A
	MOVQ  32(R13), AX
	MOVQ  AX, x4-40(SP)
	MULXQ AX, AX, SI
	ADOXQ AX, BP

	// (A,t[5])  := t[5] + x[5]*y[0] + A
	MOVQ  40(R13), AX
	MOVQ  AX, x5-48(SP)
	MULXQ AX, AX, DI
	ADOXQ AX, SI

	// (A,t[6])  := t[6] + x[6]*y[0] + A
	MOVQ  48(R13), AX
	MOVQ  AX, x6-56(SP)
	MULXQ AX, AX, R8
	ADOXQ AX, DI

	// (A,t[7])  := t[7] + x[7]*y[0] + A
	MOVQ  56(R13), AX
	MOVQ  AX, x7-64(SP)
	MULXQ AX, AX, R9
	ADOXQ AX, R8

	// (A,t[8])  := t[8] + x[8]*y[0] + A
	MOVQ  64(R13), AX
	MOVQ  AX, x8-72(SP)
	MULXQ AX, AX, R10
	ADOXQ AX, R9

	// (A,t[9])  := t[9] + x[9]*y[0] + A
	MOVQ  72(R13), AX
	MOVQ  AX, x9-80(SP)
	MULXQ AX, AX, R11
	ADOXQ AX, R10

	// (A,t[10])  := t[10] + x[10]*y[0] + A
	MOVQ  80(R13), AX
	MOVQ  AX, x10-88(SP)
	MULXQ AX, AX, R12
	ADOXQ AX, R11

	// (A,t[11])  := t[11] + x[11]*y[0] + A
	MOVQ  88(R13), AX
	MOVQ  AX, x11-96(SP)
	MULXQ AX, AX, R13
	ADOXQ AX, R12

	// A += carries from ADCXQ and ADOXQ
	MOVQ  $0, DX
	ADOXQ DX, R13
	PUSHQ R13

	// m := t[0]*q'[0] mod W
	MOVQ  qInv0<>(SB), DX
	IMULQ R14, DX

	// clear the flags
	XORQ AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11

	// t[11] = C + A
	POPQ  R13
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ R13, R12

	// clear the flags
	XORQ DX, DX
	MOVQ y+16(FP), DX
	MOVQ 8(DX), DX

	// (A,t[0])  := t[0] + x[0]*y[1] + A
	MULXQ x0-8(SP), AX, R13
	ADOXQ AX, R14

	// (A,t[1])  := t[1] + x[1]*y[1] + A
	ADCXQ R13, R15
	MULXQ x1-16(SP), AX, R13
	ADOXQ AX, R15

	// (A,t[2])  := t[2] + x[2]*y[1] + A
	ADCXQ R13, CX
	MULXQ x2-24(SP), AX, R13
	ADOXQ AX, CX

	// (A,t[3])  := t[3] + x[3]*y[1] + A
	ADCXQ R13, BX
	MULXQ x3-32(SP), AX, R13
	ADOXQ AX, BX

	// (A,t[4])  := t[4] + x[4]*y[1] + A
	ADCXQ R13, BP
	MULXQ x4-40(SP), AX, R13
	ADOXQ AX, BP

	// (A,t[5])  := t[5] + x[5]*y[1] + A
	ADCXQ R13, SI
	MULXQ x5-48(SP), AX, R13
	ADOXQ AX, SI

	// (A,t[6])  := t[6] + x[6]*y[1] + A
	ADCXQ R13, DI
	MULXQ x6-56(SP), AX, R13
	ADOXQ AX, DI

	// (A,t[7])  := t[7] + x[7]*y[1] + A
	ADCXQ R13, R8
	MULXQ x7-64(SP), AX, R13
	ADOXQ AX, R8

	// (A,t[8])  := t[8] + x[8]*y[1] + A
	ADCXQ R13, R9
	MULXQ x8-72(SP), AX, R13
	ADOXQ AX, R9

	// (A,t[9])  := t[9] + x[9]*y[1] + A
	ADCXQ R13, R10
	MULXQ x9-80(SP), AX, R13
	ADOXQ AX, R10

	// (A,t[10])  := t[10] + x[10]*y[1] + A
	ADCXQ R13, R11
	MULXQ x10-88(SP), AX, R13
	ADOXQ AX, R11

	// (A,t[11])  := t[11] + x[11]*y[1] + A
	ADCXQ R13, R12
	MULXQ x11-96(SP), AX, R13
	ADOXQ AX, R12

	// A += carries from ADCXQ and ADOXQ
	MOVQ  $0, DX
	ADCXQ DX, R13
	ADOXQ DX, R13
	PUSHQ R13

	// m := t[0]*q'[0] mod W
	MOVQ  qInv0<>(SB), DX
	IMULQ R14, DX

	// clear the flags
	XORQ AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11

	// t[11] = C + A
	POPQ  R13
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ R13, R12

	// clear the flags
	XORQ DX, DX
	MOVQ y+16(FP), DX
	MOVQ 16(DX), DX

	// (A,t[0])  := t[0] + x[0]*y[2] + A
	MULXQ x0-8(SP), AX, R13
	ADOXQ AX, R14

	// (A,t[1])  := t[1] + x[1]*y[2] + A
	ADCXQ R13, R15
	MULXQ x1-16(SP), AX, R13
	ADOXQ AX, R15

	// (A,t[2])  := t[2] + x[2]*y[2] + A
	ADCXQ R13, CX
	MULXQ x2-24(SP), AX, R13
	ADOXQ AX, CX

	// (A,t[3])  := t[3] + x[3]*y[2] + A
	ADCXQ R13, BX
	MULXQ x3-32(SP), AX, R13
	ADOXQ AX, BX

	// (A,t[4])  := t[4] + x[4]*y[2] + A
	ADCXQ R13, BP
	MULXQ x4-40(SP), AX, R13
	ADOXQ AX, BP

	// (A,t[5])  := t[5] + x[5]*y[2] + A
	ADCXQ R13, SI
	MULXQ x5-48(SP), AX, R13
	ADOXQ AX, SI

	// (A,t[6])  := t[6] + x[6]*y[2] + A
	ADCXQ R13, DI
	MULXQ x6-56(SP), AX, R13
	ADOXQ AX, DI

	// (A,t[7])  := t[7] + x[7]*y[2] + A
	ADCXQ R13, R8
	MULXQ x7-64(SP), AX, R13
	ADOXQ AX, R8

	// (A,t[8])  := t[8] + x[8]*y[2] + A
	ADCXQ R13, R9
	MULXQ x8-72(SP), AX, R13
	ADOXQ AX, R9

	// (A,t[9])  := t[9] + x[9]*y[2] + A
	ADCXQ R13, R10
	MULXQ x9-80(SP), AX, R13
	ADOXQ AX, R10

	// (A,t[10])  := t[10] + x[10]*y[2] + A
	ADCXQ R13, R11
	MULXQ x10-88(SP), AX, R13
	ADOXQ AX, R11

	// (A,t[11])  := t[11] + x[11]*y[2] + A
	ADCXQ R13, R12
	MULXQ x11-96(SP), AX, R13
	ADOXQ AX, R12

	// A += carries from ADCXQ and ADOXQ
	MOVQ  $0, DX
	ADCXQ DX, R13
	ADOXQ DX, R13
	PUSHQ R13

	// m := t[0]*q'[0] mod W
	MOVQ  qInv0<>(SB), DX
	IMULQ R14, DX

	// clear the flags
	XORQ AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11

	// t[11] = C + A
	POPQ  R13
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ R13, R12

	// clear the flags
	XORQ DX, DX
	MOVQ y+16(FP), DX
	MOVQ 24(DX), DX

	// (A,t[0])  := t[0] + x[0]*y[3] + A
	MULXQ x0-8(SP), AX, R13
	ADOXQ AX, R14

	// (A,t[1])  := t[1] + x[1]*y[3] + A
	ADCXQ R13, R15
	MULXQ x1-16(SP), AX, R13
	ADOXQ AX, R15

	// (A,t[2])  := t[2] + x[2]*y[3] + A
	ADCXQ R13, CX
	MULXQ x2-24(SP), AX, R13
	ADOXQ AX, CX

	// (A,t[3])  := t[3] + x[3]*y[3] + A
	ADCXQ R13, BX
	MULXQ x3-32(SP), AX, R13
	ADOXQ AX, BX

	// (A,t[4])  := t[4] + x[4]*y[3] + A
	ADCXQ R13, BP
	MULXQ x4-40(SP), AX, R13
	ADOXQ AX, BP

	// (A,t[5])  := t[5] + x[5]*y[3] + A
	ADCXQ R13, SI
	MULXQ x5-48(SP), AX, R13
	ADOXQ AX, SI

	// (A,t[6])  := t[6] + x[6]*y[3] + A
	ADCXQ R13, DI
	MULXQ x6-56(SP), AX, R13
	ADOXQ AX, DI

	// (A,t[7])  := t[7] + x[7]*y[3] + A
	ADCXQ R13, R8
	MULXQ x7-64(SP), AX, R13
	ADOXQ AX, R8

	// (A,t[8])  := t[8] + x[8]*y[3] + A
	ADCXQ R13, R9
	MULXQ x8-72(SP), AX, R13
	ADOXQ AX, R9

	// (A,t[9])  := t[9] + x[9]*y[3] + A
	ADCXQ R13, R10
	MULXQ x9-80(SP), AX, R13
	ADOXQ AX, R10

	// (A,t[10])  := t[10] + x[10]*y[3] + A
	ADCXQ R13, R11
	MULXQ x10-88(SP), AX, R13
	ADOXQ AX, R11

	// (A,t[11])  := t[11] + x[11]*y[3] + A
	ADCXQ R13, R12
	MULXQ x11-96(SP), AX, R13
	ADOXQ AX, R12

	// A += carries from ADCXQ and ADOXQ
	MOVQ  $0, DX
	ADCXQ DX, R13
	ADOXQ DX, R13
	PUSHQ R13

	// m := t[0]*q'[0] mod W
	MOVQ  qInv0<>(SB), DX
	IMULQ R14, DX

	// clear the flags
	XORQ AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11

	// t[11] = C + A
	POPQ  R13
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ R13, R12

	// clear the flags
	XORQ DX, DX
	MOVQ y+16(FP), DX
	MOVQ 32(DX), DX

	// (A,t[0])  := t[0] + x[0]*y[4] + A
	MULXQ x0-8(SP), AX, R13
	ADOXQ AX, R14

	// (A,t[1])  := t[1] + x[1]*y[4] + A
	ADCXQ R13, R15
	MULXQ x1-16(SP), AX, R13
	ADOXQ AX, R15

	// (A,t[2])  := t[2] + x[2]*y[4] + A
	ADCXQ R13, CX
	MULXQ x2-24(SP), AX, R13
	ADOXQ AX, CX

	// (A,t[3])  := t[3] + x[3]*y[4] + A
	ADCXQ R13, BX
	MULXQ x3-32(SP), AX, R13
	ADOXQ AX, BX

	// (A,t[4])  := t[4] + x[4]*y[4] + A
	ADCXQ R13, BP
	MULXQ x4-40(SP), AX, R13
	ADOXQ AX, BP

	// (A,t[5])  := t[5] + x[5]*y[4] + A
	ADCXQ R13, SI
	MULXQ x5-48(SP), AX, R13
	ADOXQ AX, SI

	// (A,t[6])  := t[6] + x[6]*y[4] + A
	ADCXQ R13, DI
	MULXQ x6-56(SP), AX, R13
	ADOXQ AX, DI

	// (A,t[7])  := t[7] + x[7]*y[4] + A
	ADCXQ R13, R8
	MULXQ x7-64(SP), AX, R13
	ADOXQ AX, R8

	// (A,t[8])  := t[8] + x[8]*y[4] + A
	ADCXQ R13, R9
	MULXQ x8-72(SP), AX, R13
	ADOXQ AX, R9

	// (A,t[9])  := t[9] + x[9]*y[4] + A
	ADCXQ R13, R10
	MULXQ x9-80(SP), AX, R13
	ADOXQ AX, R10

	// (A,t[10])  := t[10] + x[10]*y[4] + A
	ADCXQ R13, R11
	MULXQ x10-88(SP), AX, R13
	ADOXQ AX, R11

	// (A,t[11])  := t[11] + x[11]*y[4] + A
	ADCXQ R13, R12
	MULXQ x11-96(SP), AX, R13
	ADOXQ AX, R12

	// A += carries from ADCXQ and ADOXQ
	MOVQ  $0, DX
	ADCXQ DX, R13
	ADOXQ DX, R13
	PUSHQ R13

	// m := t[0]*q'[0] mod W
	MOVQ  qInv0<>(SB), DX
	IMULQ R14, DX

	// clear the flags
	XORQ AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11

	// t[11] = C + A
	POPQ  R13
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ R13, R12

	// clear the flags
	XORQ DX, DX
	MOVQ y+16(FP), DX
	MOVQ 40(DX), DX

	// (A,t[0])  := t[0] + x[0]*y[5] + A
	MULXQ x0-8(SP), AX, R13
	ADOXQ AX, R14

	// (A,t[1])  := t[1] + x[1]*y[5] + A
	ADCXQ R13, R15
	MULXQ x1-16(SP), AX, R13
	ADOXQ AX, R15

	// (A,t[2])  := t[2] + x[2]*y[5] + A
	ADCXQ R13, CX
	MULXQ x2-24(SP), AX, R13
	ADOXQ AX, CX

	// (A,t[3])  := t[3] + x[3]*y[5] + A
	ADCXQ R13, BX
	MULXQ x3-32(SP), AX, R13
	ADOXQ AX, BX

	// (A,t[4])  := t[4] + x[4]*y[5] + A
	ADCXQ R13, BP
	MULXQ x4-40(SP), AX, R13
	ADOXQ AX, BP

	// (A,t[5])  := t[5] + x[5]*y[5] + A
	ADCXQ R13, SI
	MULXQ x5-48(SP), AX, R13
	ADOXQ AX, SI

	// (A,t[6])  := t[6] + x[6]*y[5] + A
	ADCXQ R13, DI
	MULXQ x6-56(SP), AX, R13
	ADOXQ AX, DI

	// (A,t[7])  := t[7] + x[7]*y[5] + A
	ADCXQ R13, R8
	MULXQ x7-64(SP), AX, R13
	ADOXQ AX, R8

	// (A,t[8])  := t[8] + x[8]*y[5] + A
	ADCXQ R13, R9
	MULXQ x8-72(SP), AX, R13
	ADOXQ AX, R9

	// (A,t[9])  := t[9] + x[9]*y[5] + A
	ADCXQ R13, R10
	MULXQ x9-80(SP), AX, R13
	ADOXQ AX, R10

	// (A,t[10])  := t[10] + x[10]*y[5] + A
	ADCXQ R13, R11
	MULXQ x10-88(SP), AX, R13
	ADOXQ AX, R11

	// (A,t[11])  := t[11] + x[11]*y[5] + A
	ADCXQ R13, R12
	MULXQ x11-96(SP), AX, R13
	ADOXQ AX, R12

	// A += carries from ADCXQ and ADOXQ
	MOVQ  $0, DX
	ADCXQ DX, R13
	ADOXQ DX, R13
	PUSHQ R13

	// m := t[0]*q'[0] mod W
	MOVQ  qInv0<>(SB), DX
	IMULQ R14, DX

	// clear the flags
	XORQ AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11

	// t[11] = C + A
	POPQ  R13
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ R13, R12

	// clear the flags
	XORQ DX, DX
	MOVQ y+16(FP), DX
	MOVQ 48(DX), DX

	// (A,t[0])  := t[0] + x[0]*y[6] + A
	MULXQ x0-8(SP), AX, R13
	ADOXQ AX, R14

	// (A,t[1])  := t[1] + x[1]*y[6] + A
	ADCXQ R13, R15
	MULXQ x1-16(SP), AX, R13
	ADOXQ AX, R15

	// (A,t[2])  := t[2] + x[2]*y[6] + A
	ADCXQ R13, CX
	MULXQ x2-24(SP), AX, R13
	ADOXQ AX, CX

	// (A,t[3])  := t[3] + x[3]*y[6] + A
	ADCXQ R13, BX
	MULXQ x3-32(SP), AX, R13
	ADOXQ AX, BX

	// (A,t[4])  := t[4] + x[4]*y[6] + A
	ADCXQ R13, BP
	MULXQ x4-40(SP), AX, R13
	ADOXQ AX, BP

	// (A,t[5])  := t[5] + x[5]*y[6] + A
	ADCXQ R13, SI
	MULXQ x5-48(SP), AX, R13
	ADOXQ AX, SI

	// (A,t[6])  := t[6] + x[6]*y[6] + A
	ADCXQ R13, DI
	MULXQ x6-56(SP), AX, R13
	ADOXQ AX, DI

	// (A,t[7])  := t[7] + x[7]*y[6] + A
	ADCXQ R13, R8
	MULXQ x7-64(SP), AX, R13
	ADOXQ AX, R8

	// (A,t[8])  := t[8] + x[8]*y[6] + A
	ADCXQ R13, R9
	MULXQ x8-72(SP), AX, R13
	ADOXQ AX, R9

	// (A,t[9])  := t[9] + x[9]*y[6] + A
	ADCXQ R13, R10
	MULXQ x9-80(SP), AX, R13
	ADOXQ AX, R10

	// (A,t[10])  := t[10] + x[10]*y[6] + A
	ADCXQ R13, R11
	MULXQ x10-88(SP), AX, R13
	ADOXQ AX, R11

	// (A,t[11])  := t[11] + x[11]*y[6] + A
	ADCXQ R13, R12
	MULXQ x11-96(SP), AX, R13
	ADOXQ AX, R12

	// A += carries from ADCXQ and ADOXQ
	MOVQ  $0, DX
	ADCXQ DX, R13
	ADOXQ DX, R13
	PUSHQ R13

	// m := t[0]*q'[0] mod W
	MOVQ  qInv0<>(SB), DX
	IMULQ R14, DX

	// clear the flags
	XORQ AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11

	// t[11] = C + A
	POPQ  R13
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ R13, R12

	// clear the flags
	XORQ DX, DX
	MOVQ y+16(FP), DX
	MOVQ 56(DX), DX

	// (A,t[0])  := t[0] + x[0]*y[7] + A
	MULXQ x0-8(SP), AX, R13
	ADOXQ AX, R14

	// (A,t[1])  := t[1] + x[1]*y[7] + A
	ADCXQ R13, R15
	MULXQ x1-16(SP), AX, R13
	ADOXQ AX, R15

	// (A,t[2])  := t[2] + x[2]*y[7] + A
	ADCXQ R13, CX
	MULXQ x2-24(SP), AX, R13
	ADOXQ AX, CX

	// (A,t[3])  := t[3] + x[3]*y[7] + A
	ADCXQ R13, BX
	MULXQ x3-32(SP), AX, R13
	ADOXQ AX, BX

	// (A,t[4])  := t[4] + x[4]*y[7] + A
	ADCXQ R13, BP
	MULXQ x4-40(SP), AX, R13
	ADOXQ AX, BP

	// (A,t[5])  := t[5] + x[5]*y[7] + A
	ADCXQ R13, SI
	MULXQ x5-48(SP), AX, R13
	ADOXQ AX, SI

	// (A,t[6])  := t[6] + x[6]*y[7] + A
	ADCXQ R13, DI
	MULXQ x6-56(SP), AX, R13
	ADOXQ AX, DI

	// (A,t[7])  := t[7] + x[7]*y[7] + A
	ADCXQ R13, R8
	MULXQ x7-64(SP), AX, R13
	ADOXQ AX, R8

	// (A,t[8])  := t[8] + x[8]*y[7] + A
	ADCXQ R13, R9
	MULXQ x8-72(SP), AX, R13
	ADOXQ AX, R9

	// (A,t[9])  := t[9] + x[9]*y[7] + A
	ADCXQ R13, R10
	MULXQ x9-80(SP), AX, R13
	ADOXQ AX, R10

	// (A,t[10])  := t[10] + x[10]*y[7] + A
	ADCXQ R13, R11
	MULXQ x10-88(SP), AX, R13
	ADOXQ AX, R11

	// (A,t[11])  := t[11] + x[11]*y[7] + A
	ADCXQ R13, R12
	MULXQ x11-96(SP), AX, R13
	ADOXQ AX, R12

	// A += carries from ADCXQ and ADOXQ
	MOVQ  $0, DX
	ADCXQ DX, R13
	ADOXQ DX, R13
	PUSHQ R13

	// m := t[0]*q'[0] mod W
	MOVQ  qInv0<>(SB), DX
	IMULQ R14, DX

	// clear the flags
	XORQ AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11

	// t[11] = C + A
	POPQ  R13
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ R13, R12

	// clear the flags
	XORQ DX, DX
	MOVQ y+16(FP), DX
	MOVQ 64(DX), DX

	// (A,t[0])  := t[0] + x[0]*y[8] + A
	MULXQ x0-8(SP), AX, R13
	ADOXQ AX, R14

	// (A,t[1])  := t[1] + x[1]*y[8] + A
	ADCXQ R13, R15
	MULXQ x1-16(SP), AX, R13
	ADOXQ AX, R15

	// (A,t[2])  := t[2] + x[2]*y[8] + A
	ADCXQ R13, CX
	MULXQ x2-24(SP), AX, R13
	ADOXQ AX, CX

	// (A,t[3])  := t[3] + x[3]*y[8] + A
	ADCXQ R13, BX
	MULXQ x3-32(SP), AX, R13
	ADOXQ AX, BX

	// (A,t[4])  := t[4] + x[4]*y[8] + A
	ADCXQ R13, BP
	MULXQ x4-40(SP), AX, R13
	ADOXQ AX, BP

	// (A,t[5])  := t[5] + x[5]*y[8] + A
	ADCXQ R13, SI
	MULXQ x5-48(SP), AX, R13
	ADOXQ AX, SI

	// (A,t[6])  := t[6] + x[6]*y[8] + A
	ADCXQ R13, DI
	MULXQ x6-56(SP), AX, R13
	ADOXQ AX, DI

	// (A,t[7])  := t[7] + x[7]*y[8] + A
	ADCXQ R13, R8
	MULXQ x7-64(SP), AX, R13
	ADOXQ AX, R8

	// (A,t[8])  := t[8] + x[8]*y[8] + A
	ADCXQ R13, R9
	MULXQ x8-72(SP), AX, R13
	ADOXQ AX, R9

	// (A,t[9])  := t[9] + x[9]*y[8] + A
	ADCXQ R13, R10
	MULXQ x9-80(SP), AX, R13
	ADOXQ AX, R10

	// (A,t[10])  := t[10] + x[10]*y[8] + A
	ADCXQ R13, R11
	MULXQ x10-88(SP), AX, R13
	ADOXQ AX, R11

	// (A,t[11])  := t[11] + x[11]*y[8] + A
	ADCXQ R13, R12
	MULXQ x11-96(SP), AX, R13
	ADOXQ AX, R12

	// A += carries from ADCXQ and ADOXQ
	MOVQ  $0, DX
	ADCXQ DX, R13
	ADOXQ DX, R13
	PUSHQ R13

	// m := t[0]*q'[0] mod W
	MOVQ  qInv0<>(SB), DX
	IMULQ R14, DX

	// clear the flags
	XORQ AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11

	// t[11] = C + A
	POPQ  R13
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ R13, R12

	// clear the flags
	XORQ DX, DX
	MOVQ y+16(FP), DX
	MOVQ 72(DX), DX

	// (A,t[0])  := t[0] + x[0]*y[9] + A
	MULXQ x0-8(SP), AX, R13
	ADOXQ AX, R14

	// (A,t[1])  := t[1] + x[1]*y[9] + A
	ADCXQ R13, R15
	MULXQ x1-16(SP), AX, R13
	ADOXQ AX, R15

	// (A,t[2])  := t[2] + x[2]*y[9] + A
	ADCXQ R13, CX
	MULXQ x2-24(SP), AX, R13
	ADOXQ AX, CX

	// (A,t[3])  := t[3] + x[3]*y[9] + A
	ADCXQ R13, BX
	MULXQ x3-32(SP), AX, R13
	ADOXQ AX, BX

	// (A,t[4])  := t[4] + x[4]*y[9] + A
	ADCXQ R13, BP
	MULXQ x4-40(SP), AX, R13
	ADOXQ AX, BP

	// (A,t[5])  := t[5] + x[5]*y[9] + A
	ADCXQ R13, SI
	MULXQ x5-48(SP), AX, R13
	ADOXQ AX, SI

	// (A,t[6])  := t[6] + x[6]*y[9] + A
	ADCXQ R13, DI
	MULXQ x6-56(SP), AX, R13
	ADOXQ AX, DI

	// (A,t[7])  := t[7] + x[7]*y[9] + A
	ADCXQ R13, R8
	MULXQ x7-64(SP), AX, R13
	ADOXQ AX, R8

	// (A,t[8])  := t[8] + x[8]*y[9] + A
	ADCXQ R13, R9
	MULXQ x8-72(SP), AX, R13
	ADOXQ AX, R9

	// (A,t[9])  := t[9] + x[9]*y[9] + A
	ADCXQ R13, R10
	MULXQ x9-80(SP), AX, R13
	ADOXQ AX, R10

	// (A,t[10])  := t[10] + x[10]*y[9] + A
	ADCXQ R13, R11
	MULXQ x10-88(SP), AX, R13
	ADOXQ AX, R11

	// (A,t[11])  := t[11] + x[11]*y[9] + A
	ADCXQ R13, R12
	MULXQ x11-96(SP), AX, R13
	ADOXQ AX, R12

	// A += carries from ADCXQ and ADOXQ
	MOVQ  $0, DX
	ADCXQ DX, R13
	ADOXQ DX, R13
	PUSHQ R13

	// m := t[0]*q'[0] mod W
	MOVQ  qInv0<>(SB), DX
	IMULQ R14, DX

	// clear the flags
	XORQ AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11

	// t[11] = C + A
	POPQ  R13
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ R13, R12

	// clear the flags
	XORQ DX, DX
	MOVQ y+16(FP), DX
	MOVQ 80(DX), DX

	// (A,t[0])  := t[0] + x[0]*y[10] + A
	MULXQ x0-8(SP), AX, R13
	ADOXQ AX, R14

	// (A,t[1])  := t[1] + x[1]*y[10] + A
	ADCXQ R13, R15
	MULXQ x1-16(SP), AX, R13
	ADOXQ AX, R15

	// (A,t[2])  := t[2] + x[2]*y[10] + A
	ADCXQ R13, CX
	MULXQ x2-24(SP), AX, R13
	ADOXQ AX, CX

	// (A,t[3])  := t[3] + x[3]*y[10] + A
	ADCXQ R13, BX
	MULXQ x3-32(SP), AX, R13
	ADOXQ AX, BX

	// (A,t[4])  := t[4] + x[4]*y[10] + A
	ADCXQ R13, BP
	MULXQ x4-40(SP), AX, R13
	ADOXQ AX, BP

	// (A,t[5])  := t[5] + x[5]*y[10] + A
	ADCXQ R13, SI
	MULXQ x5-48(SP), AX, R13
	ADOXQ AX, SI

	// (A,t[6])  := t[6] + x[6]*y[10] + A
	ADCXQ R13, DI
	MULXQ x6-56(SP), AX, R13
	ADOXQ AX, DI

	// (A,t[7])  := t[7] + x[7]*y[10] + A
	ADCXQ R13, R8
	MULXQ x7-64(SP), AX, R13
	ADOXQ AX, R8

	// (A,t[8])  := t[8] + x[8]*y[10] + A
	ADCXQ R13, R9
	MULXQ x8-72(SP), AX, R13
	ADOXQ AX, R9

	// (A,t[9])  := t[9] + x[9]*y[10] + A
	ADCXQ R13, R10
	MULXQ x9-80(SP), AX, R13
	ADOXQ AX, R10

	// (A,t[10])  := t[10] + x[10]*y[10] + A
	ADCXQ R13, R11
	MULXQ x10-88(SP), AX, R13
	ADOXQ AX, R11

	// (A,t[11])  := t[11] + x[11]*y[10] + A
	ADCXQ R13, R12
	MULXQ x11-96(SP), AX, R13
	ADOXQ AX, R12

	// A += carries from ADCXQ and ADOXQ
	MOVQ  $0, DX
	ADCXQ DX, R13
	ADOXQ DX, R13
	PUSHQ R13

	// m := t[0]*q'[0] mod W
	MOVQ  qInv0<>(SB), DX
	IMULQ R14, DX

	// clear the flags
	XORQ AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11

	// t[11] = C + A
	POPQ  R13
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ R13, R12

	// clear the flags
	XORQ DX, DX
	MOVQ y+16(FP), DX
	MOVQ 88(DX), DX

	// (A,t[0])  := t[0] + x[0]*y[11] + A
	MULXQ x0-8(SP), AX, R13
	ADOXQ AX, R14

	// (A,t[1])  := t[1] + x[1]*y[11] + A
	ADCXQ R13, R15
	MULXQ x1-16(SP), AX, R13
	ADOXQ AX, R15

	// (A,t[2])  := t[2] + x[2]*y[11] + A
	ADCXQ R13, CX
	MULXQ x2-24(SP), AX, R13
	ADOXQ AX, CX

	// (A,t[3])  := t[3] + x[3]*y[11] + A
	ADCXQ R13, BX
	MULXQ x3-32(SP), AX, R13
	ADOXQ AX, BX

	// (A,t[4])  := t[4] + x[4]*y[11] + A
	ADCXQ R13, BP
	MULXQ x4-40(SP), AX, R13
	ADOXQ AX, BP

	// (A,t[5])  := t[5] + x[5]*y[11] + A
	ADCXQ R13, SI
	MULXQ x5-48(SP), AX, R13
	ADOXQ AX, SI

	// (A,t[6])  := t[6] + x[6]*y[11] + A
	ADCXQ R13, DI
	MULXQ x6-56(SP), AX, R13
	ADOXQ AX, DI

	// (A,t[7])  := t[7] + x[7]*y[11] + A
	ADCXQ R13, R8
	MULXQ x7-64(SP), AX, R13
	ADOXQ AX, R8

	// (A,t[8])  := t[8] + x[8]*y[11] + A
	ADCXQ R13, R9
	MULXQ x8-72(SP), AX, R13
	ADOXQ AX, R9

	// (A,t[9])  := t[9] + x[9]*y[11] + A
	ADCXQ R13, R10
	MULXQ x9-80(SP), AX, R13
	ADOXQ AX, R10

	// (A,t[10])  := t[10] + x[10]*y[11] + A
	ADCXQ R13, R11
	MULXQ x10-88(SP), AX, R13
	ADOXQ AX, R11

	// (A,t[11])  := t[11] + x[11]*y[11] + A
	ADCXQ R13, R12
	MULXQ x11-96(SP), AX, R13
	ADOXQ AX, R12

	// A += carries from ADCXQ and ADOXQ
	MOVQ  $0, DX
	ADCXQ DX, R13
	ADOXQ DX, R13
	PUSHQ R13

	// m := t[0]*q'[0] mod W
	MOVQ  qInv0<>(SB), DX
	IMULQ R14, DX

	// clear the flags
	XORQ AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11

	// t[11] = C + A
	POPQ    R13
	MOVQ    $0, AX
	ADCXQ   AX, R12
	ADOXQ   R13, R12
	MOVQ    res+0(FP), R13
	MOVQ    R14, t0-8(SP)
	SUBQ    q<>+0(SB), R14
	MOVQ    R15, t1-16(SP)
	SBBQ    q<>+8(SB), R15
	MOVQ    CX, t2-24(SP)
	SBBQ    q<>+16(SB), CX
	MOVQ    BX, t3-32(SP)
	SBBQ    q<>+24(SB), BX
	MOVQ    BP, t4-40(SP)
	SBBQ    q<>+32(SB), BP
	MOVQ    SI, t5-48(SP)
	SBBQ    q<>+40(SB), SI
	MOVQ    DI, t6-56(SP)
	SBBQ    q<>+48(SB), DI
	MOVQ    R8, t7-64(SP)
	SBBQ    q<>+56(SB), R8
	MOVQ    R9, t8-72(SP)
	SBBQ    q<>+64(SB), R9
	MOVQ    R10, t9-80(SP)
	SBBQ    q<>+72(SB), R10
	MOVQ    R11, t10-88(SP)
	SBBQ    q<>+80(SB), R11
	MOVQ    R12, t11-96(SP)
	SBBQ    q<>+88(SB), R12
	CMOVQCS t0-8(SP), R14
	CMOVQCS t1-16(SP), R15
	CMOVQCS t2-24(SP), CX
	CMOVQCS t3-32(SP), BX
	CMOVQCS t4-40(SP), BP
	CMOVQCS t5-48(SP), SI
	CMOVQCS t6-56(SP), DI
	CMOVQCS t7-64(SP), R8
	CMOVQCS t8-72(SP), R9
	CMOVQCS t9-80(SP), R10
	CMOVQCS t10-88(SP), R11
	CMOVQCS t11-96(SP), R12
	MOVQ    R14, 0(R13)
	MOVQ    R15, 8(R13)
	MOVQ    CX, 16(R13)
	MOVQ    BX, 24(R13)
	MOVQ    BP, 32(R13)
	MOVQ    SI, 40(R13)
	MOVQ    DI, 48(R13)
	MOVQ    R8, 56(R13)
	MOVQ    R9, 64(R13)
	MOVQ    R10, 72(R13)
	MOVQ    R11, 80(R13)
	MOVQ    R12, 88(R13)
	RET

l3:
	MOVQ res+0(FP), AX
	MOVQ AX, (SP)
	MOVQ x+8(FP), AX
	MOVQ AX, 8(SP)
	MOVQ y+16(FP), AX
	MOVQ AX, 16(SP)
	CALL ·_mulGeneric(SB)
	RET

TEXT ·fromMont(SB), $96-8
	NO_LOCAL_POINTERS

	// the algorithm is described here
	// https://hackmd.io/@zkteam/modular_multiplication
	// when y = 1 we have:
	// for i=0 to N-1
	// 		t[i] = x[i]
	// for i=0 to N-1
	// 		m := t[0]*q'[0] mod W
	// 		C,_ := t[0] + m*q[0]
	// 		for j=1 to N-1
	// 		    (C,t[j-1]) := t[j] + m*q[j] + C
	// 		t[N-1] = C
	CMPB ·supportAdx(SB), $1
	JNE  l4
	MOVQ res+0(FP), R13
	MOVQ 0(R13), R14
	MOVQ 8(R13), R15
	MOVQ 16(R13), CX
	MOVQ 24(R13), BX
	MOVQ 32(R13), BP
	MOVQ 40(R13), SI
	MOVQ 48(R13), DI
	MOVQ 56(R13), R8
	MOVQ 64(R13), R9
	MOVQ 72(R13), R10
	MOVQ 80(R13), R11
	MOVQ 88(R13), R12
	XORQ DX, DX

	// m := t[0]*q'[0] mod W
	MOVQ  R14, DX
	MULXQ qInv0<>(SB), DX, AX
	XORQ  AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ AX, R12
	XORQ  DX, DX

	// m := t[0]*q'[0] mod W
	MOVQ  R14, DX
	MULXQ qInv0<>(SB), DX, AX
	XORQ  AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ AX, R12
	XORQ  DX, DX

	// m := t[0]*q'[0] mod W
	MOVQ  R14, DX
	MULXQ qInv0<>(SB), DX, AX
	XORQ  AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ AX, R12
	XORQ  DX, DX

	// m := t[0]*q'[0] mod W
	MOVQ  R14, DX
	MULXQ qInv0<>(SB), DX, AX
	XORQ  AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ AX, R12
	XORQ  DX, DX

	// m := t[0]*q'[0] mod W
	MOVQ  R14, DX
	MULXQ qInv0<>(SB), DX, AX
	XORQ  AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ AX, R12
	XORQ  DX, DX

	// m := t[0]*q'[0] mod W
	MOVQ  R14, DX
	MULXQ qInv0<>(SB), DX, AX
	XORQ  AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ AX, R12
	XORQ  DX, DX

	// m := t[0]*q'[0] mod W
	MOVQ  R14, DX
	MULXQ qInv0<>(SB), DX, AX
	XORQ  AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ AX, R12
	XORQ  DX, DX

	// m := t[0]*q'[0] mod W
	MOVQ  R14, DX
	MULXQ qInv0<>(SB), DX, AX
	XORQ  AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ AX, R12
	XORQ  DX, DX

	// m := t[0]*q'[0] mod W
	MOVQ  R14, DX
	MULXQ qInv0<>(SB), DX, AX
	XORQ  AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ AX, R12
	XORQ  DX, DX

	// m := t[0]*q'[0] mod W
	MOVQ  R14, DX
	MULXQ qInv0<>(SB), DX, AX
	XORQ  AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ AX, R12
	XORQ  DX, DX

	// m := t[0]*q'[0] mod W
	MOVQ  R14, DX
	MULXQ qInv0<>(SB), DX, AX
	XORQ  AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ R12, R11
	MULXQ q<>+88(SB), AX, R12
	ADOXQ AX, R11
	MOVQ  $0, AX
	ADCXQ AX, R12
	ADOXQ AX, R12
	XORQ  DX, DX

	// m := t[0]*q'[0] mod W
	MOVQ  R14, DX
	MULXQ qInv0<>(SB), DX, AX
	XORQ  AX, AX

	// C,_ := t[0] + m*q[0]
	MULXQ q<>+0(SB), AX, R13
	ADCXQ R14, AX
	MOVQ  R13, R14

	// (C,t[0]) := t[1] + m*q[1] + C
	ADCXQ R15, R14
	MULXQ q<>+8(SB), AX, R15
	ADOXQ AX, R14

	// (C,t[1]) := t[2] + m*q[2] + C
	ADCXQ CX, R15
	MULXQ q<>+16(SB), AX, CX
	ADOXQ AX, R15

	// (C,t[2]) := t[3] + m*q[3] + C
	ADCXQ BX, CX
	MULXQ q<>+24(SB), AX, BX
	ADOXQ AX, CX

	// (C,t[3]) := t[4] + m*q[4] + C
	ADCXQ BP, BX
	MULXQ q<>+32(SB), AX, BP
	ADOXQ AX, BX

	// (C,t[4]) := t[5] + m*q[5] + C
	ADCXQ SI, BP
	MULXQ q<>+40(SB), AX, SI
	ADOXQ AX, BP

	// (C,t[5]) := t[6] + m*q[6] + C
	ADCXQ DI, SI
	MULXQ q<>+48(SB), AX, DI
	ADOXQ AX, SI

	// (C,t[6]) := t[7] + m*q[7] + C
	ADCXQ R8, DI
	MULXQ q<>+56(SB), AX, R8
	ADOXQ AX, DI

	// (C,t[7]) := t[8] + m*q[8] + C
	ADCXQ R9, R8
	MULXQ q<>+64(SB), AX, R9
	ADOXQ AX, R8

	// (C,t[8]) := t[9] + m*q[9] + C
	ADCXQ R10, R9
	MULXQ q<>+72(SB), AX, R10
	ADOXQ AX, R9

	// (C,t[9]) := t[10] + m*q[10] + C
	ADCXQ R11, R10
	MULXQ q<>+80(SB), AX, R11
	ADOXQ AX, R10

	// (C,t[10]) := t[11] + m*q[11] + C
	ADCXQ   R12, R11
	MULXQ   q<>+88(SB), AX, R12
	ADOXQ   AX, R11
	MOVQ    $0, AX
	ADCXQ   AX, R12
	ADOXQ   AX, R12
	MOVQ    res+0(FP), R13
	MOVQ    R14, t0-8(SP)
	SUBQ    q<>+0(SB), R14
	MOVQ    R15, t1-16(SP)
	SBBQ    q<>+8(SB), R15
	MOVQ    CX, t2-24(SP)
	SBBQ    q<>+16(SB), CX
	MOVQ    BX, t3-32(SP)
	SBBQ    q<>+24(SB), BX
	MOVQ    BP, t4-40(SP)
	SBBQ    q<>+32(SB), BP
	MOVQ    SI, t5-48(SP)
	SBBQ    q<>+40(SB), SI
	MOVQ    DI, t6-56(SP)
	SBBQ    q<>+48(SB), DI
	MOVQ    R8, t7-64(SP)
	SBBQ    q<>+56(SB), R8
	MOVQ    R9, t8-72(SP)
	SBBQ    q<>+64(SB), R9
	MOVQ    R10, t9-80(SP)
	SBBQ    q<>+72(SB), R10
	MOVQ    R11, t10-88(SP)
	SBBQ    q<>+80(SB), R11
	MOVQ    R12, t11-96(SP)
	SBBQ    q<>+88(SB), R12
	CMOVQCS t0-8(SP), R14
	CMOVQCS t1-16(SP), R15
	CMOVQCS t2-24(SP), CX
	CMOVQCS t3-32(SP), BX
	CMOVQCS t4-40(SP), BP
	CMOVQCS t5-48(SP), SI
	CMOVQCS t6-56(SP), DI
	CMOVQCS t7-64(SP), R8
	CMOVQCS t8-72(SP), R9
	CMOVQCS t9-80(SP), R10
	CMOVQCS t10-88(SP), R11
	CMOVQCS t11-96(SP), R12
	MOVQ    R14, 0(R13)
	MOVQ    R15, 8(R13)
	MOVQ    CX, 16(R13)
	MOVQ    BX, 24(R13)
	MOVQ    BP, 32(R13)
	MOVQ    SI, 40(R13)
	MOVQ    DI, 48(R13)
	MOVQ    R8, 56(R13)
	MOVQ    R9, 64(R13)
	MOVQ    R10, 72(R13)
	MOVQ    R11, 80(R13)
	MOVQ    R12, 88(R13)
	RET

l4:
	MOVQ res+0(FP), AX
	MOVQ AX, (SP)
	CALL ·_fromMontGeneric(SB)
	RET

TEXT ·reduce(SB), $96-8
	MOVQ    res+0(FP), AX
	MOVQ    0(AX), DX
	MOVQ    8(AX), CX
	MOVQ    16(AX), BX
	MOVQ    24(AX), BP
	MOVQ    32(AX), SI
	MOVQ    40(AX), DI
	MOVQ    48(AX), R8
	MOVQ    56(AX), R9
	MOVQ    64(AX), R10
	MOVQ    72(AX), R11
	MOVQ    80(AX), R12
	MOVQ    88(AX), R13
	MOVQ    DX, t0-8(SP)
	SUBQ    q<>+0(SB), DX
	MOVQ    CX, t1-16(SP)
	SBBQ    q<>+8(SB), CX
	MOVQ    BX, t2-24(SP)
	SBBQ    q<>+16(SB), BX
	MOVQ    BP, t3-32(SP)
	SBBQ    q<>+24(SB), BP
	MOVQ    SI, t4-40(SP)
	SBBQ    q<>+32(SB), SI
	MOVQ    DI, t5-48(SP)
	SBBQ    q<>+40(SB), DI
	MOVQ    R8, t6-56(SP)
	SBBQ    q<>+48(SB), R8
	MOVQ    R9, t7-64(SP)
	SBBQ    q<>+56(SB), R9
	MOVQ    R10, t8-72(SP)
	SBBQ    q<>+64(SB), R10
	MOVQ    R11, t9-80(SP)
	SBBQ    q<>+72(SB), R11
	MOVQ    R12, t10-88(SP)
	SBBQ    q<>+80(SB), R12
	MOVQ    R13, t11-96(SP)
	SBBQ    q<>+88(SB), R13
	CMOVQCS t0-8(SP), DX
	CMOVQCS t1-16(SP), CX
	CMOVQCS t2-24(SP), BX
	CMOVQCS t3-32(SP), BP
	CMOVQCS t4-40(SP), SI
	CMOVQCS t5-48(SP), DI
	CMOVQCS t6-56(SP), R8
	CMOVQCS t7-64(SP), R9
	CMOVQCS t8-72(SP), R10
	CMOVQCS t9-80(SP), R11
	CMOVQCS t10-88(SP), R12
	CMOVQCS t11-96(SP), R13
	MOVQ    DX, 0(AX)
	MOVQ    CX, 8(AX)
	MOVQ    BX, 16(AX)
	MOVQ    BP, 24(AX)
	MOVQ    SI, 32(AX)
	MOVQ    DI, 40(AX)
	MOVQ    R8, 48(AX)
	MOVQ    R9, 56(AX)
	MOVQ    R10, 64(AX)
	MOVQ    R11, 72(AX)
	MOVQ    R12, 80(AX)
	MOVQ    R13, 88(AX)
	RET

// MulBy3(x *Element)
TEXT ·MulBy3(SB), $96-8
	MOVQ    x+0(FP), AX
	MOVQ    0(AX), DX
	MOVQ    8(AX), CX
	MOVQ    16(AX), BX
	MOVQ    24(AX), BP
	MOVQ    32(AX), SI
	MOVQ    40(AX), DI
	MOVQ    48(AX), R8
	MOVQ    56(AX), R9
	MOVQ    64(AX), R10
	MOVQ    72(AX), R11
	MOVQ    80(AX), R12
	MOVQ    88(AX), R13
	ADDQ    DX, DX
	ADCQ    CX, CX
	ADCQ    BX, BX
	ADCQ    BP, BP
	ADCQ    SI, SI
	ADCQ    DI, DI
	ADCQ    R8, R8
	ADCQ    R9, R9
	ADCQ    R10, R10
	ADCQ    R11, R11
	ADCQ    R12, R12
	ADCQ    R13, R13
	MOVQ    DX, t0-8(SP)
	SUBQ    q<>+0(SB), DX
	MOVQ    CX, t1-16(SP)
	SBBQ    q<>+8(SB), CX
	MOVQ    BX, t2-24(SP)
	SBBQ    q<>+16(SB), BX
	MOVQ    BP, t3-32(SP)
	SBBQ    q<>+24(SB), BP
	MOVQ    SI, t4-40(SP)
	SBBQ    q<>+32(SB), SI
	MOVQ    DI, t5-48(SP)
	SBBQ    q<>+40(SB), DI
	MOVQ    R8, t6-56(SP)
	SBBQ    q<>+48(SB), R8
	MOVQ    R9, t7-64(SP)
	SBBQ    q<>+56(SB), R9
	MOVQ    R10, t8-72(SP)
	SBBQ    q<>+64(SB), R10
	MOVQ    R11, t9-80(SP)
	SBBQ    q<>+72(SB), R11
	MOVQ    R12, t10-88(SP)
	SBBQ    q<>+80(SB), R12
	MOVQ    R13, t11-96(SP)
	SBBQ    q<>+88(SB), R13
	CMOVQCS t0-8(SP), DX
	CMOVQCS t1-16(SP), CX
	CMOVQCS t2-24(SP), BX
	CMOVQCS t3-32(SP), BP
	CMOVQCS t4-40(SP), SI
	CMOVQCS t5-48(SP), DI
	CMOVQCS t6-56(SP), R8
	CMOVQCS t7-64(SP), R9
	CMOVQCS t8-72(SP), R10
	CMOVQCS t9-80(SP), R11
	CMOVQCS t10-88(SP), R12
	CMOVQCS t11-96(SP), R13
	ADDQ    0(AX), DX
	ADCQ    8(AX), CX
	ADCQ    16(AX), BX
	ADCQ    24(AX), BP
	ADCQ    32(AX), SI
	ADCQ    40(AX), DI
	ADCQ    48(AX), R8
	ADCQ    56(AX), R9
	ADCQ    64(AX), R10
	ADCQ    72(AX), R11
	ADCQ    80(AX), R12
	ADCQ    88(AX), R13
	MOVQ    DX, t0-8(SP)
	SUBQ    q<>+0(SB), DX
	MOVQ    CX, t1-16(SP)
	SBBQ    q<>+8(SB), CX
	MOVQ    BX, t2-24(SP)
	SBBQ    q<>+16(SB), BX
	MOVQ    BP, t3-32(SP)
	SBBQ    q<>+24(SB), BP
	MOVQ    SI, t4-40(SP)
	SBBQ    q<>+32(SB), SI
	MOVQ    DI, t5-48(SP)
	SBBQ    q<>+40(SB), DI
	MOVQ    R8, t6-56(SP)
	SBBQ    q<>+48(SB), R8
	MOVQ    R9, t7-64(SP)
	SBBQ    q<>+56(SB), R9
	MOVQ    R10, t8-72(SP)
	SBBQ    q<>+64(SB), R10
	MOVQ    R11, t9-80(SP)
	SBBQ    q<>+72(SB), R11
	MOVQ    R12, t10-88(SP)
	SBBQ    q<>+80(SB), R12
	MOVQ    R13, t11-96(SP)
	SBBQ    q<>+88(SB), R13
	CMOVQCS t0-8(SP), DX
	CMOVQCS t1-16(SP), CX
	CMOVQCS t2-24(SP), BX
	CMOVQCS t3-32(SP), BP
	CMOVQCS t4-40(SP), SI
	CMOVQCS t5-48(SP), DI
	CMOVQCS t6-56(SP), R8
	CMOVQCS t7-64(SP), R9
	CMOVQCS t8-72(SP), R10
	CMOVQCS t9-80(SP), R11
	CMOVQCS t10-88(SP), R12
	CMOVQCS t11-96(SP), R13
	MOVQ    DX, 0(AX)
	MOVQ    CX, 8(AX)
	MOVQ    BX, 16(AX)
	MOVQ    BP, 24(AX)
	MOVQ    SI, 32(AX)
	MOVQ    DI, 40(AX)
	MOVQ    R8, 48(AX)
	MOVQ    R9, 56(AX)
	MOVQ    R10, 64(AX)
	MOVQ    R11, 72(AX)
	MOVQ    R12, 80(AX)
	MOVQ    R13, 88(AX)
	RET

// MulBy5(x *Element)
TEXT ·MulBy5(SB), $96-8
	MOVQ    x+0(FP), AX
	MOVQ    0(AX), DX
	MOVQ    8(AX), CX
	MOVQ    16(AX), BX
	MOVQ    24(AX), BP
	MOVQ    32(AX), SI
	MOVQ    40(AX), DI
	MOVQ    48(AX), R8
	MOVQ    56(AX), R9
	MOVQ    64(AX), R10
	MOVQ    72(AX), R11
	MOVQ    80(AX), R12
	MOVQ    88(AX), R13
	ADDQ    DX, DX
	ADCQ    CX, CX
	ADCQ    BX, BX
	ADCQ    BP, BP
	ADCQ    SI, SI
	ADCQ    DI, DI
	ADCQ    R8, R8
	ADCQ    R9, R9
	ADCQ    R10, R10
	ADCQ    R11, R11
	ADCQ    R12, R12
	ADCQ    R13, R13
	MOVQ    DX, t0-8(SP)
	SUBQ    q<>+0(SB), DX
	MOVQ    CX, t1-16(SP)
	SBBQ    q<>+8(SB), CX
	MOVQ    BX, t2-24(SP)
	SBBQ    q<>+16(SB), BX
	MOVQ    BP, t3-32(SP)
	SBBQ    q<>+24(SB), BP
	MOVQ    SI, t4-40(SP)
	SBBQ    q<>+32(SB), SI
	MOVQ    DI, t5-48(SP)
	SBBQ    q<>+40(SB), DI
	MOVQ    R8, t6-56(SP)
	SBBQ    q<>+48(SB), R8
	MOVQ    R9, t7-64(SP)
	SBBQ    q<>+56(SB), R9
	MOVQ    R10, t8-72(SP)
	SBBQ    q<>+64(SB), R10
	MOVQ    R11, t9-80(SP)
	SBBQ    q<>+72(SB), R11
	MOVQ    R12, t10-88(SP)
	SBBQ    q<>+80(SB), R12
	MOVQ    R13, t11-96(SP)
	SBBQ    q<>+88(SB), R13
	CMOVQCS t0-8(SP), DX
	CMOVQCS t1-16(SP), CX
	CMOVQCS t2-24(SP), BX
	CMOVQCS t3-32(SP), BP
	CMOVQCS t4-40(SP), SI
	CMOVQCS t5-48(SP), DI
	CMOVQCS t6-56(SP), R8
	CMOVQCS t7-64(SP), R9
	CMOVQCS t8-72(SP), R10
	CMOVQCS t9-80(SP), R11
	CMOVQCS t10-88(SP), R12
	CMOVQCS t11-96(SP), R13
	ADDQ    DX, DX
	ADCQ    CX, CX
	ADCQ    BX, BX
	ADCQ    BP, BP
	ADCQ    SI, SI
	ADCQ    DI, DI
	ADCQ    R8, R8
	ADCQ    R9, R9
	ADCQ    R10, R10
	ADCQ    R11, R11
	ADCQ    R12, R12
	ADCQ    R13, R13
	MOVQ    DX, t0-8(SP)
	SUBQ    q<>+0(SB), DX
	MOVQ    CX, t1-16(SP)
	SBBQ    q<>+8(SB), CX
	MOVQ    BX, t2-24(SP)
	SBBQ    q<>+16(SB), BX
	MOVQ    BP, t3-32(SP)
	SBBQ    q<>+24(SB), BP
	MOVQ    SI, t4-40(SP)
	SBBQ    q<>+32(SB), SI
	MOVQ    DI, t5-48(SP)
	SBBQ    q<>+40(SB), DI
	MOVQ    R8, t6-56(SP)
	SBBQ    q<>+48(SB), R8
	MOVQ    R9, t7-64(SP)
	SBBQ    q<>+56(SB), R9
	MOVQ    R10, t8-72(SP)
	SBBQ    q<>+64(SB), R10
	MOVQ    R11, t9-80(SP)
	SBBQ    q<>+72(SB), R11
	MOVQ    R12, t10-88(SP)
	SBBQ    q<>+80(SB), R12
	MOVQ    R13, t11-96(SP)
	SBBQ    q<>+88(SB), R13
	CMOVQCS t0-8(SP), DX
	CMOVQCS t1-16(SP), CX
	CMOVQCS t2-24(SP), BX
	CMOVQCS t3-32(SP), BP
	CMOVQCS t4-40(SP), SI
	CMOVQCS t5-48(SP), DI
	CMOVQCS t6-56(SP), R8
	CMOVQCS t7-64(SP), R9
	CMOVQCS t8-72(SP), R10
	CMOVQCS t9-80(SP), R11
	CMOVQCS t10-88(SP), R12
	CMOVQCS t11-96(SP), R13
	ADDQ    0(AX), DX
	ADCQ    8(AX), CX
	ADCQ    16(AX), BX
	ADCQ    24(AX), BP
	ADCQ    32(AX), SI
	ADCQ    40(AX), DI
	ADCQ    48(AX), R8
	ADCQ    56(AX), R9
	ADCQ    64(AX), R10
	ADCQ    72(AX), R11
	ADCQ    80(AX), R12
	ADCQ    88(AX), R13
	MOVQ    DX, t0-8(SP)
	SUBQ    q<>+0(SB), DX
	MOVQ    CX, t1-16(SP)
	SBBQ    q<>+8(SB), CX
	MOVQ    BX, t2-24(SP)
	SBBQ    q<>+16(SB), BX
	MOVQ    BP, t3-32(SP)
	SBBQ    q<>+24(SB), BP
	MOVQ    SI, t4-40(SP)
	SBBQ    q<>+32(SB), SI
	MOVQ    DI, t5-48(SP)
	SBBQ    q<>+40(SB), DI
	MOVQ    R8, t6-56(SP)
	SBBQ    q<>+48(SB), R8
	MOVQ    R9, t7-64(SP)
	SBBQ    q<>+56(SB), R9
	MOVQ    R10, t8-72(SP)
	SBBQ    q<>+64(SB), R10
	MOVQ    R11, t9-80(SP)
	SBBQ    q<>+72(SB), R11
	MOVQ    R12, t10-88(SP)
	SBBQ    q<>+80(SB), R12
	MOVQ    R13, t11-96(SP)
	SBBQ    q<>+88(SB), R13
	CMOVQCS t0-8(SP), DX
	CMOVQCS t1-16(SP), CX
	CMOVQCS t2-24(SP), BX
	CMOVQCS t3-32(SP), BP
	CMOVQCS t4-40(SP), SI
	CMOVQCS t5-48(SP), DI
	CMOVQCS t6-56(SP), R8
	CMOVQCS t7-64(SP), R9
	CMOVQCS t8-72(SP), R10
	CMOVQCS t9-80(SP), R11
	CMOVQCS t10-88(SP), R12
	CMOVQCS t11-96(SP), R13
	MOVQ    DX, 0(AX)
	MOVQ    CX, 8(AX)
	MOVQ    BX, 16(AX)
	MOVQ    BP, 24(AX)
	MOVQ    SI, 32(AX)
	MOVQ    DI, 40(AX)
	MOVQ    R8, 48(AX)
	MOVQ    R9, 56(AX)
	MOVQ    R10, 64(AX)
	MOVQ    R11, 72(AX)
	MOVQ    R12, 80(AX)
	MOVQ    R13, 88(AX)
	RET
