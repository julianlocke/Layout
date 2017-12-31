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

import Foundation
import XCTest
@testable import Layout

class LayoutTests: XCTestCase {

    var containerView: View!
    var view: View!

    override func setUp() {
        super.setUp()
        containerView = View()
        view = View()
        containerView.addSubview(view)
    }

    override func tearDown() {
        view.removeFromSuperview()
        containerView = nil
        view = nil
    }

    func testThatNothingIsActiveInitially() {
        let layout = Layout(rootView: containerView) { _ in
            view.makeConstraints(.center())
        }

        XCTAssertTrue(layout.__activeConstraints__for_testing_only.isEmpty)
    }

    func testBasicActivationAndDeactivation() {
        let layout = Layout(rootView: containerView) { _ in
            view.makeConstraints(.center())
        }

        layout.setIsActive(true)
        XCTAssertTrue(!layout.__activeConstraints__for_testing_only.isEmpty)
        XCTAssertTrue(constraintsAreEqual(layout.__activeConstraints__for_testing_only, view.makeConstraints(.center())))
        layout.setIsActive(false)
        XCTAssertTrue(layout.__activeConstraints__for_testing_only.isEmpty)
    }

    #if os(iOS) || os(tvOS)
    func testTraitCollectionUpdates() {
        let globalConstraints: [ConstraintGroup] = [.setSize(CGSize(width: 100, height: 100))]
        let horizontallyCompactConstraints: [ConstraintGroup] = [.center()]
        let horizontallyRegularConstraints: [ConstraintGroup] = [.align(.leadingMargin), .align(.topMargin)]

        let layout = Layout(rootView: containerView) { ctx in
            view.makeConstraints(for: globalConstraints)

            ctx.when(.verticallyRegular) {
                ctx.when(.horizontallyCompact) {
                    view.makeConstraints(for: horizontallyCompactConstraints)
                }

                ctx.when(.horizontallyRegular) {
                    view.makeConstraints(for: horizontallyRegularConstraints)
                }
            }
        }

        layout.setIsActive(true)
        XCTAssertTrue(constraintsAreEqual(layout.__activeConstraints__for_testing_only, view.makeConstraints(for: globalConstraints)))
        layout.updateActiveConstraints(with: .verticallyRegular, .horizontallyCompact)
        XCTAssertTrue(constraintsAreEqual(layout.__activeConstraints__for_testing_only, view.makeConstraints(for: globalConstraints + horizontallyCompactConstraints)))
        layout.updateActiveConstraints(with: .verticallyRegular, .horizontallyRegular)
        XCTAssertTrue(constraintsAreEqual(layout.__activeConstraints__for_testing_only, view.makeConstraints(for: globalConstraints + horizontallyRegularConstraints)))
        layout.setIsActive(false)
        XCTAssertTrue(layout.__activeConstraints__for_testing_only.isEmpty)
    }
    #endif
}
