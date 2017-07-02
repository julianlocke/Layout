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

// iOS/tvOS only.

class LayoutMarginsSpec: QuickSpec {

    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("LayoutMarginsSpec") {
            var parentView: View!
            var view: View!

            beforeEach {
                parentView = View(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                parentView.layoutMargins = EdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

                view = View()
                view.layoutMargins = EdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

                parentView.addSubview(view)
            }

            afterEach {
                parentView = nil
                view = nil
            }

            it("creates margin constraints correctly") {
                view.immediatelyApplyLayout(
                    Layout.topMargin,
                    Layout.leftMargin,
                    Layout.bottomMargin,
                    Layout.rightMargin
                )

                expect(view.frame) == CGRect(x: 5, y: 5, width: 90, height: 90)
            }

            it("creates margin(of:) constraints correctly") {
                view.immediatelyApplyLayout(
                    Layout.topMargin(of: parentView),
                    Layout.leftMargin(of: parentView),
                    Layout.bottomMargin(of: parentView),
                    Layout.rightMargin(of: parentView)
                )

                expect(view.frame) == CGRect(x: 5, y: 5, width: 90, height: 90)
            }

            it("creates marginTo constraints correctly") {
                view.immediatelyApplyLayout(
                    Layout.topToMargin,
                    Layout.leftToMargin,
                    Layout.bottomToMargin,
                    Layout.rightToMargin
                )

                expect(view.frame) == CGRect(x: 10, y: 10, width: 80, height: 80)
            }
        }
    }
}
