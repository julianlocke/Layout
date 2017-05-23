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

class LayoutsSpec: QuickSpec {

    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("LayoutsSpec") {
            var parentView: View!
            var view: View!

            beforeEach {
                parentView = View(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                view = View()
                parentView.addSubview(view)
            }

            afterEach {
                parentView = nil
                view = nil
            }

            it("creates positional constraints correctly") {
                view.immediatelyApplyLayout(
                    Layout.top,
                    Layout.left,
                    Layout.bottom,
                    Layout.right
                )

                expect(view.frame).to(equal(parentView.frame))
            }

            it("creates positional(of:) constraints correctly") {
                view.immediatelyApplyLayout(
                    Layout.top(of: parentView),
                    Layout.left(of: parentView),
                    Layout.bottom(of: parentView),
                    Layout.right(of: parentView)
                )

                expect(view.frame).to(equal(parentView.frame))
            }

            it("creates width and height constraints correctly") {
                view.immediatelyApplyLayout(
                    Layout.width,
                    Layout.height
                )

                expect(view.frame.size).to(equal(parentView.frame.size))
            }

            it("creates width(of:) and height(of:) constraints correctly") {
                view.immediatelyApplyLayout(
                    Layout.width(of: parentView),
                    Layout.height(of: parentView)
                )

                expect(view.frame.size).to(equal(parentView.frame.size))
            }

            it("creates size constraints correctly") {
                view.immediatelyApplyLayout(Layout.size)
                expect(view.frame.size).to(equal(parentView.frame.size))
            }

            it("creates size(of:) constraints correctly") {
                view.immediatelyApplyLayout(Layout.size(of: parentView))
                expect(view.frame.size).to(equal(parentView.frame.size))
            }
        }
    }
}