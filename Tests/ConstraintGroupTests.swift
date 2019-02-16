/*
 The MIT License (MIT)

 Copyright (c) 2019 Cameron Pulsford

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

import UIKit
import XCTest

@testable import Layout

class ConstraintGroupTests: XCTestCase {

    var parentView: UIView!
    var view: UIView!

    override func setUp() {
        super.setUp()
        parentView = UIView()
        view = UIView()
        parentView.addSubview(view)
    }

    func testAlignX() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .leading,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .leading,
                multiplier: 1,
                constant: 0
            )
        ]

        var constraints = [NSLayoutConstraint]()

        constraints = view.makeConstraints(.align(.leading, .equal, to: .leading, of: parentView, multiplier: 1, offsetBy: 0))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.leading, .equal, to: .leading, of: parentView, multiplier: 1))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.leading, .equal, to: .leading, of: parentView))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.leading, .equal, to: .leading))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.leading, .equal))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.leading))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testAlignY() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .top,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .top,
                multiplier: 1,
                constant: 0
            )
        ]

        var constraints = [NSLayoutConstraint]()

        constraints = view.makeConstraints(.align(.top, .equal, to: .top, of: parentView, multiplier: 1, offsetBy: 0))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.top, .equal, to: .top, of: parentView, multiplier: 1))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.top, .equal, to: .top, of: parentView))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.top, .equal, to: .top))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.top, .equal))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.top))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testFixed() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 100
            )
        ]

        var constraints = [NSLayoutConstraint]()

        constraints = view.makeConstraints(.setFixed(.width, .equal, to: 100))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.setFixed(.width, to: 100))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testRelative() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .width,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .width,
                multiplier: 0.5,
                constant: 0
            )
        ]

        var constraints = [NSLayoutConstraint]()

        constraints = view.makeConstraints(.setRelative(.width, .equal, to: 0.5, of: parentView, attribute: .width, constant: 0))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.setRelative(.width, .equal, to: 0.5, of: parentView, attribute: .width))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.setRelative(.width, .equal, to: 0.5, of: parentView))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.setRelative(.width, .equal, to: 0.5))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.setRelative(.width, to: 0.5))
        XCTAssertEqual(desiredConstraints, constraints)
    }
}
