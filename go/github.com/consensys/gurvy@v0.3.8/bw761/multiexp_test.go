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

// Code generated by gurvy DO NOT EDIT

package bw761

import (
	"fmt"
	"math/big"
	"math/bits"
	"runtime"
	"testing"

	"github.com/consensys/gurvy/bw761/fr"
	"github.com/leanovate/gopter"
	"github.com/leanovate/gopter/prop"
)

func TestMultiExpg1(t *testing.T) {

	parameters := gopter.DefaultTestParameters()
	parameters.MinSuccessfulTests = 2

	properties := gopter.NewProperties(parameters)

	genScalar := GenFr()

	// size of the multiExps
	const nbSamples = 500

	// multi exp points
	var samplePoints [nbSamples]G1Affine
	var g G1Jac
	g.Set(&g1Gen)
	for i := 1; i <= nbSamples; i++ {
		samplePoints[i-1].FromJacobian(&g)
		g.AddAssign(&g1Gen)
	}

	// final scalar to use in double and add method (without mixer factor)
	// n(n+1)(2n+1)/6  (sum of the squares from 1 to n)
	var scalar big.Int
	scalar.SetInt64(nbSamples)
	scalar.Mul(&scalar, new(big.Int).SetInt64(nbSamples+1))
	scalar.Mul(&scalar, new(big.Int).SetInt64(2*nbSamples+1))
	scalar.Div(&scalar, new(big.Int).SetInt64(6))

	properties.Property("[G1] Multi exponentation (c=4) should be consistant with sum of square", prop.ForAll(
		func(mixer fr.Element) bool {

			var result, expected G1Jac

			// mixer ensures that all the words of a fpElement are set
			var sampleScalars [nbSamples]fr.Element

			for i := 1; i <= nbSamples; i++ {
				sampleScalars[i-1].SetUint64(uint64(i)).
					MulAssign(&mixer).
					FromMont()
			}

			// semaphore to limit number of cpus
			opt := NewCPUSemaphore(runtime.NumCPU())
			opt.lock.Lock()
			scalars := partitionScalars(sampleScalars[:], 4)
			result.msmC4(samplePoints[:], scalars, opt)

			// compute expected result with double and add
			var finalScalar, mixerBigInt big.Int
			finalScalar.Mul(&scalar, mixer.ToBigIntRegular(&mixerBigInt))
			expected.ScalarMultiplication(&g1Gen, &finalScalar)

			return result.Equal(&expected)
		},
		genScalar,
	))

	properties.Property("[G1] Multi exponentation (c=8) should be consistant with sum of square", prop.ForAll(
		func(mixer fr.Element) bool {

			var result, expected G1Jac

			// mixer ensures that all the words of a fpElement are set
			var sampleScalars [nbSamples]fr.Element

			for i := 1; i <= nbSamples; i++ {
				sampleScalars[i-1].SetUint64(uint64(i)).
					MulAssign(&mixer).
					FromMont()
			}

			// semaphore to limit number of cpus
			opt := NewCPUSemaphore(runtime.NumCPU())
			opt.lock.Lock()
			scalars := partitionScalars(sampleScalars[:], 8)
			result.msmC8(samplePoints[:], scalars, opt)

			// compute expected result with double and add
			var finalScalar, mixerBigInt big.Int
			finalScalar.Mul(&scalar, mixer.ToBigIntRegular(&mixerBigInt))
			expected.ScalarMultiplication(&g1Gen, &finalScalar)

			return result.Equal(&expected)
		},
		genScalar,
	))

	if !testing.Short() {

		properties.Property("[G1] Multi exponentation (c=16) should be consistant with sum of square", prop.ForAll(
			func(mixer fr.Element) bool {

				var result, expected G1Jac

				// mixer ensures that all the words of a fpElement are set
				var sampleScalars [nbSamples]fr.Element

				for i := 1; i <= nbSamples; i++ {
					sampleScalars[i-1].SetUint64(uint64(i)).
						MulAssign(&mixer).
						FromMont()
				}

				// semaphore to limit number of cpus
				opt := NewCPUSemaphore(runtime.NumCPU())
				opt.lock.Lock()
				scalars := partitionScalars(sampleScalars[:], 16)
				result.msmC16(samplePoints[:], scalars, opt)

				// compute expected result with double and add
				var finalScalar, mixerBigInt big.Int
				finalScalar.Mul(&scalar, mixer.ToBigIntRegular(&mixerBigInt))
				expected.ScalarMultiplication(&g1Gen, &finalScalar)

				return result.Equal(&expected)
			},
			genScalar,
		))

	}

	// note : this test is here as we expect to have a different multiExp than the above bucket method
	// for small number of points
	properties.Property("[G1] Multi exponentation (<50points) should be consistant with sum of square", prop.ForAll(
		func(mixer fr.Element) bool {

			var g G1Jac
			g.Set(&g1Gen)

			// mixer ensures that all the words of a fpElement are set
			samplePoints := make([]G1Affine, 30)
			sampleScalars := make([]fr.Element, 30)

			for i := 1; i <= 30; i++ {
				sampleScalars[i-1].SetUint64(uint64(i)).
					MulAssign(&mixer).
					FromMont()
				samplePoints[i-1].FromJacobian(&g)
				g.AddAssign(&g1Gen)
			}

			var op1MultiExp G1Affine
			op1MultiExp.MultiExp(samplePoints, sampleScalars)

			var finalBigScalar fr.Element
			var finalBigScalarBi big.Int
			var op1ScalarMul G1Affine
			finalBigScalar.SetString("9455").MulAssign(&mixer)
			finalBigScalar.ToBigIntRegular(&finalBigScalarBi)
			op1ScalarMul.ScalarMultiplication(&g1GenAff, &finalBigScalarBi)

			return op1ScalarMul.Equal(&op1MultiExp)
		},
		genScalar,
	))

	properties.TestingRun(t, gopter.ConsoleReporter(false))
}

func BenchmarkMultiExpg1(b *testing.B) {
	// ensure every words of the scalars are filled
	var mixer fr.Element
	mixer.SetString("7716837800905789770901243404444209691916730933998574719964609384059111546487")

	const pow = (bits.UintSize / 2) - (bits.UintSize / 8) // 24 on 64 bits arch, 12 on 32 bits
	const nbSamples = 1 << pow

	var samplePoints [nbSamples]G1Affine
	var sampleScalars [nbSamples]fr.Element

	for i := 1; i <= nbSamples; i++ {
		sampleScalars[i-1].SetUint64(uint64(i)).
			Mul(&sampleScalars[i-1], &mixer).
			FromMont()
		samplePoints[i-1] = g1GenAff
	}

	var testPoint G1Affine

	for i := 5; i <= pow; i++ {
		using := 1 << i

		b.Run(fmt.Sprintf("%d points", using), func(b *testing.B) {
			b.ResetTimer()
			for j := 0; j < b.N; j++ {
				testPoint.MultiExp(samplePoints[:using], sampleScalars[:using])
			}
		})
	}
}

func TestMultiExpg2(t *testing.T) {

	parameters := gopter.DefaultTestParameters()
	parameters.MinSuccessfulTests = 2

	properties := gopter.NewProperties(parameters)

	genScalar := GenFr()

	// size of the multiExps
	const nbSamples = 500

	// multi exp points
	var samplePoints [nbSamples]G2Affine
	var g G2Jac
	g.Set(&g2Gen)
	for i := 1; i <= nbSamples; i++ {
		samplePoints[i-1].FromJacobian(&g)
		g.AddAssign(&g2Gen)
	}

	// final scalar to use in double and add method (without mixer factor)
	// n(n+1)(2n+1)/6  (sum of the squares from 1 to n)
	var scalar big.Int
	scalar.SetInt64(nbSamples)
	scalar.Mul(&scalar, new(big.Int).SetInt64(nbSamples+1))
	scalar.Mul(&scalar, new(big.Int).SetInt64(2*nbSamples+1))
	scalar.Div(&scalar, new(big.Int).SetInt64(6))

	properties.Property("[G2] Multi exponentation (c=4) should be consistant with sum of square", prop.ForAll(
		func(mixer fr.Element) bool {

			var result, expected G2Jac

			// mixer ensures that all the words of a fpElement are set
			var sampleScalars [nbSamples]fr.Element

			for i := 1; i <= nbSamples; i++ {
				sampleScalars[i-1].SetUint64(uint64(i)).
					MulAssign(&mixer).
					FromMont()
			}

			// semaphore to limit number of cpus
			opt := NewCPUSemaphore(runtime.NumCPU())
			opt.lock.Lock()
			scalars := partitionScalars(sampleScalars[:], 4)
			result.msmC4(samplePoints[:], scalars, opt)

			// compute expected result with double and add
			var finalScalar, mixerBigInt big.Int
			finalScalar.Mul(&scalar, mixer.ToBigIntRegular(&mixerBigInt))
			expected.ScalarMultiplication(&g2Gen, &finalScalar)

			return result.Equal(&expected)
		},
		genScalar,
	))

	properties.Property("[G2] Multi exponentation (c=8) should be consistant with sum of square", prop.ForAll(
		func(mixer fr.Element) bool {

			var result, expected G2Jac

			// mixer ensures that all the words of a fpElement are set
			var sampleScalars [nbSamples]fr.Element

			for i := 1; i <= nbSamples; i++ {
				sampleScalars[i-1].SetUint64(uint64(i)).
					MulAssign(&mixer).
					FromMont()
			}

			// semaphore to limit number of cpus
			opt := NewCPUSemaphore(runtime.NumCPU())
			opt.lock.Lock()
			scalars := partitionScalars(sampleScalars[:], 8)
			result.msmC8(samplePoints[:], scalars, opt)

			// compute expected result with double and add
			var finalScalar, mixerBigInt big.Int
			finalScalar.Mul(&scalar, mixer.ToBigIntRegular(&mixerBigInt))
			expected.ScalarMultiplication(&g2Gen, &finalScalar)

			return result.Equal(&expected)
		},
		genScalar,
	))

	if !testing.Short() {

		properties.Property("[G2] Multi exponentation (c=16) should be consistant with sum of square", prop.ForAll(
			func(mixer fr.Element) bool {

				var result, expected G2Jac

				// mixer ensures that all the words of a fpElement are set
				var sampleScalars [nbSamples]fr.Element

				for i := 1; i <= nbSamples; i++ {
					sampleScalars[i-1].SetUint64(uint64(i)).
						MulAssign(&mixer).
						FromMont()
				}

				// semaphore to limit number of cpus
				opt := NewCPUSemaphore(runtime.NumCPU())
				opt.lock.Lock()
				scalars := partitionScalars(sampleScalars[:], 16)
				result.msmC16(samplePoints[:], scalars, opt)

				// compute expected result with double and add
				var finalScalar, mixerBigInt big.Int
				finalScalar.Mul(&scalar, mixer.ToBigIntRegular(&mixerBigInt))
				expected.ScalarMultiplication(&g2Gen, &finalScalar)

				return result.Equal(&expected)
			},
			genScalar,
		))

	}

	// note : this test is here as we expect to have a different multiExp than the above bucket method
	// for small number of points
	properties.Property("[G2] Multi exponentation (<50points) should be consistant with sum of square", prop.ForAll(
		func(mixer fr.Element) bool {

			var g G2Jac
			g.Set(&g2Gen)

			// mixer ensures that all the words of a fpElement are set
			samplePoints := make([]G2Affine, 30)
			sampleScalars := make([]fr.Element, 30)

			for i := 1; i <= 30; i++ {
				sampleScalars[i-1].SetUint64(uint64(i)).
					MulAssign(&mixer).
					FromMont()
				samplePoints[i-1].FromJacobian(&g)
				g.AddAssign(&g2Gen)
			}

			var op1MultiExp G2Affine
			op1MultiExp.MultiExp(samplePoints, sampleScalars)

			var finalBigScalar fr.Element
			var finalBigScalarBi big.Int
			var op1ScalarMul G2Affine
			finalBigScalar.SetString("9455").MulAssign(&mixer)
			finalBigScalar.ToBigIntRegular(&finalBigScalarBi)
			op1ScalarMul.ScalarMultiplication(&g2GenAff, &finalBigScalarBi)

			return op1ScalarMul.Equal(&op1MultiExp)
		},
		genScalar,
	))

	properties.TestingRun(t, gopter.ConsoleReporter(false))
}

func BenchmarkMultiExpg2(b *testing.B) {
	// ensure every words of the scalars are filled
	var mixer fr.Element
	mixer.SetString("7716837800905789770901243404444209691916730933998574719964609384059111546487")

	const pow = (bits.UintSize / 2) - (bits.UintSize / 8) // 24 on 64 bits arch, 12 on 32 bits
	const nbSamples = 1 << pow

	var samplePoints [nbSamples]G2Affine
	var sampleScalars [nbSamples]fr.Element

	for i := 1; i <= nbSamples; i++ {
		sampleScalars[i-1].SetUint64(uint64(i)).
			Mul(&sampleScalars[i-1], &mixer).
			FromMont()
		samplePoints[i-1] = g2GenAff
	}

	var testPoint G2Affine

	for i := 5; i <= pow; i++ {
		using := 1 << i

		b.Run(fmt.Sprintf("%d points", using), func(b *testing.B) {
			b.ResetTimer()
			for j := 0; j < b.N; j++ {
				testPoint.MultiExp(samplePoints[:using], sampleScalars[:using])
			}
		})
	}
}
