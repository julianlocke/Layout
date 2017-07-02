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

class DynamicLayoutManagerTraitSpec: QuickSpec {

    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("DynamicLayoutManagerTraitSpec") {
            describe("trait tests") {
                var rootView: TraitOverridingView!
                var view: TraitOverridingView!
                var layoutManager: DynamicLayoutManager!

                beforeEach {
                    rootView = TraitOverridingView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                    view = TraitOverridingView()
                    rootView.addSubview(view)
                    layoutManager = DynamicLayoutManager(rootView: rootView)
                }

                afterEach {
                    rootView = nil
                    view = nil
                    layoutManager = nil
                }

                it("responds to trait changes") {
                    layoutManager.add(constraintsFor: .horizontally(.regular)) {
                        view.createLayout(Layout.center, Layout.size / 2)
                    }

                    layoutManager.add(constraintsFor: .horizontally(.compact)) {
                        view.createLayout(Layout.flush)
                    }

                    layoutManager.updateTraitBasedConstraints(withTraits: .horizontally(.regular))
                    expect(view.frame) == CGRect(x: 25, y: 25, width: 50, height: 50)

                    layoutManager.updateTraitBasedConstraints(withTraits: .horizontally(.compact))
                    expect(view.frame) == rootView.frame
                }

                it("handles nested traits") {
                    rootView.overridenTraitCollection = .idiom(.phone) && .vertically(.regular)

                    layoutManager.add(constraintsFor: .idiom(.phone), {
                        view.createLayout(Layout.center)

                        layoutManager.add(constraintsFor: .vertically(.regular), {
                            view.createLayout(Layout.size / 2)
                        })

                        layoutManager.add(constraintsFor: .vertically(.compact), {
                            view.createLayout(Layout.size)
                        })
                    })

                    layoutManager.updateTraitBasedConstraints()
                    expect(view.frame) == CGRect(x: 25, y: 25, width: 50, height: 50)

                    rootView.overridenTraitCollection = .idiom(.phone) && .vertically(.compact) && .horizontally(.compact)
                    layoutManager.updateTraitBasedConstraints()

                    expect(view.frame) == rootView.frame
                }

                it("does not call blocks for the wrong idiom") {
                    rootView.overridenTraitCollection = .idiom(.phone)

                    var blockCalled = false

                    layoutManager.add(constraintsFor: .idiom(.pad), {
                        view.createLayout(Layout.center)
                        blockCalled = true
                    })

                    expect(blockCalled).to(beFalse())
                }

                it("throws errors when using applyLayout") {
                    layoutManager.add(constraintsFor: .horizontally(.regular)) {
                        expect({ view.applyLayout(Layout.center, Layout.size / 2) }() ).to(throwAssertion())
                    }
                }
            }
        }
    }
}
