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

class LayoutManagerSpec: QuickSpec {

    override func spec() {
        describe("LayoutManagerSpec") {
            var rootView: View!
            var view: View!
            var layoutManager: LayoutManager<Bool>!

            beforeEach {
                rootView = View(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                view = View()
                rootView.addSubview(view)
                layoutManager = LayoutManager(rootView: rootView)
            }

            afterEach {
                rootView = nil
                view = nil
                layoutManager = nil
            }

            it("errors when setting multiple constraints for the same key") {
                layoutManager.set(constraints: [], for: true)
                expect(layoutManager.set(constraints: [], for: true)).to(throwAssertion())
            }

            it("can switch constraints") {
                layoutManager.set(constraints: view.createLayout(Layout.center, Layout.size / 2), for: false)
                layoutManager.set(constraints: view.createLayout(Layout.center, Layout.size), for: true)

                layoutManager.activateConstraints(for: false)
                expect(layoutManager.active).to(equal(false))
                expect(view.frame).to(equal(CGRect(x: 25, y: 25, width: 50, height: 50)))

                layoutManager.activateConstraints(for: true)
                expect(layoutManager.active).to(equal(true))
                expect(view.frame).to(equal(rootView.frame))

                layoutManager.activateConstraints(for: true)
                expect(layoutManager.active).to(equal(true))
                expect(view.frame).to(equal(rootView.frame))
            }

            it("fails when activating constraints that don't exist") {
                expect(layoutManager.activateConstraints(for: true)).to(throwAssertion())
                expect(layoutManager.active).to(beNil())
            }
        }
    }
}
