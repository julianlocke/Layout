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

class SingleConstraintSpec: QuickSpec {

    override func spec() {
        describe("SingleConstraintSpec") {
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

            it("applies a single constraint") {
                let constraint = (Layout.width(of: view) == 100).constraint()
                view.updateConstraints(deactivate: [], activate: [constraint], immediately: true)
                expect(view.frame.width) == 100
            }

            it("throws errors when returning multiple constraints") {
                expect({ _ = (Layout.size(of: view) == 100).constraint() }()).to(throwAssertion())
            }
        }
    }
}
