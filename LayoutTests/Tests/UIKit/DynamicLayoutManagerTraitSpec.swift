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
import XCTest

// iOS/tvOS only.

class DynamicLayoutManagerTraitSpec: XCTestCase {

    private var rootView: TraitOverridingView!
    private var view: TraitOverridingView!
    private var layoutManager: DynamicLayoutManager!

    override func setUp() {
        super.setUp()
        rootView = TraitOverridingView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view = TraitOverridingView()
        rootView.addSubview(view)
        layoutManager = DynamicLayoutManager(rootView: rootView)
    }

    override func tearDown() {
        rootView = nil
        view = nil
        layoutManager = nil
        super.tearDown()
    }

    func testTraitChanges() {
        layoutManager.add(constraintsFor: .horizontally(.regular)) {
            view.createLayout(Layout.center, Layout.size / 2)
        }

        layoutManager.add(constraintsFor: .horizontally(.compact)) {
            view.createLayout(Layout.flush)
        }

        layoutManager.updateTraitBasedConstraints(withTraits: .horizontally(.regular))
        XCTAssertEqual(
            view.frame,
            CGRect(x: 25, y: 25, width: 50, height: 50)
        )

        layoutManager.updateTraitBasedConstraints(withTraits: .horizontally(.compact))
        XCTAssertEqual(
            view.frame,
            rootView.frame
        )
    }

    func testNestedTraits() {
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
        XCTAssertEqual(
            view.frame,
            CGRect(x: 25, y: 25, width: 50, height: 50)
        )

        rootView.overridenTraitCollection = .idiom(.phone) && .vertically(.compact) && .horizontally(.compact)
        layoutManager.updateTraitBasedConstraints()

        XCTAssertEqual(
            view.frame,
            rootView.frame
        )
    }

    func testLazyIdiom() {
        rootView.overridenTraitCollection = .idiom(.phone)

        var blockCalled = false

        layoutManager.add(constraintsFor: .idiom(.pad), {
            view.createLayout(Layout.center)
            blockCalled = true
        })

        XCTAssertFalse(blockCalled)
    }

    func testThrowsFatalError() {
        //    it("throws errors when using applyLayout") {
        //        layoutManager.add(constraintsFor: .horizontally(.regular)) {
        //            expect({ view.applyLayout(Layout.center, Layout.size / 2) }() ).to(throwAssertion())
        //        }
        //    }
    }
}