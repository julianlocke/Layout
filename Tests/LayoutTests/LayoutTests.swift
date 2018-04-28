/*
 The MIT License (MIT)

 Copyright (c) 2018 Cameron Pulsford

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

// swiftlint:disable implicitly_unwrapped_optional

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
        super.tearDown()
    }

    func testBasicAlwaysActiveConstraints() {
        let layout = Layout<String> { _ in
            view.applyConstraints(.center())
        }

        XCTAssertTrue(!layout.__activeConstraints__for_testing_only.isEmpty)
        XCTAssertEqual(layout.__activeConstraints__for_testing_only, view.makeConstraints(.center()))
    }

    #if os(iOS) || os(tvOS)
    func testTraitCollectionUpdates() {
        let globalConstraints: [ConstraintSpecGroup] = [.setSize(CGSize(width: 100, height: 100))]
        let horizontallyCompactConstraints: [ConstraintSpecGroup] = [.center()]
        let horizontallyRegularConstraints: [ConstraintSpecGroup] = [.align(.leadingMargin), .align(.topMargin)]

        let layout = Layout<String> { ctx in
            view.applyConstraints(for: globalConstraints)

            ctx.when(.verticallyRegular) {
                ctx.when(.horizontallyCompact) {
                    view.applyConstraints(for: horizontallyCompactConstraints)
                }

                ctx.when(.horizontallyRegular) {
                    view.applyConstraints(for: horizontallyRegularConstraints)
                }
            }
        }

        XCTAssertEqual(layout.__activeConstraints__for_testing_only, view.makeConstraints(for: globalConstraints))
        layout.updateTraits([.verticallyRegular, .horizontallyCompact])
        XCTAssertEqual(layout.__activeConstraints__for_testing_only, view.makeConstraints(for: globalConstraints + horizontallyCompactConstraints))
        layout.updateTraits([.verticallyRegular, .horizontallyRegular])
        XCTAssertEqual(layout.__activeConstraints__for_testing_only, view.makeConstraints(for: globalConstraints + horizontallyRegularConstraints))
        layout.updateTraits([.verticallyCompact, .horizontallyCompact])
        XCTAssertEqual(layout.__activeConstraints__for_testing_only, view.makeConstraints(for: globalConstraints))
    }
    #endif
}
