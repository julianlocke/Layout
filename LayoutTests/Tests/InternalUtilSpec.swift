/*
 The MIT License (MIT)

 Copyright (c) 2017 Cameron Pulsford

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

@testable import Layout
import Nimble
import Quick

class InternalUtilSpec: QuickSpec {

    override func spec() {
        describe("InternalUtilSpec") {
            describe("zip3") {
                it("produces the correct output") {
                    let seq1 = [1, 2, 3]
                    let seq2 = [1, 2, 3]
                    let seq3 = [1, 2, 3]

                    let result = zip3(seq1, seq2, seq3).map { arg -> [Int] in
                        let (val1, val2, val3) = arg
                        return [val1, val2, val3]
                    }

                    let expectedResult = [[1, 1, 1], [2, 2, 2], [3, 3, 3]]

                    expect(result.count) == expectedResult.count

                    for (val1, val2) in zip(result, expectedResult) {
                        expect(val1) == val2
                    }
                }

                it("crashes on mis-matched lengths") {
                    let seq1 = [1, 2, 3]
                    let seq2 = [1, 2, 3]
                    let seq3 = [1, 2]
                    expect({ _ = zip3(seq1, seq2, seq3) }()).to(throwAssertion())
                }
            }
        }
    }
}
