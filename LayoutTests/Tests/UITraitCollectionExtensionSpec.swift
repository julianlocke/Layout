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

import Quick
import Nimble
@testable import Layout

// iOS/tvOS only.

class UITraitCollectionExtensionSpec: QuickSpec {

    override func spec() {
        describe("UITraitCollectionExtensionSpec") {
            it("creates shorthand collections correctly") {
                expect(.horizontally(.regular)).to(equal(UITraitCollection(horizontalSizeClass: .regular)))
                expect(.vertically(.regular)).to(equal(UITraitCollection(verticalSizeClass: .regular)))
                expect(.idiom(.phone)).to(equal(UITraitCollection(userInterfaceIdiom: .phone)))
            }

            it("can merge multiple collections correctly") {
                let target = UITraitCollection(
                    traitsFrom: [
                        UITraitCollection(userInterfaceIdiom: .phone),
                        UITraitCollection(horizontalSizeClass: .regular)
                    ]
                )

                expect(.idiom(.phone) && .horizontally(.regular)).to(equal(target))
                expect([.idiom(.phone), .horizontally(.regular)].merged()).to(equal(target))
            }
        }
    }
}
