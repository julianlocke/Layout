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

// swiftlint:disable file_length type_body_length implicitly_unwrapped_optional

class ConstraintTests: XCTestCase {

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

    func testBasicLayoutGuide() {
        let layoutGuide = LayoutGuide()
        containerView.addLayoutGuide(layoutGuide)
        let desiredConstraints = [
            NSLayoutConstraint(
                item: layoutGuide,
                attribute: .leading,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .leading,
                multiplier: 1,
                constant: 0
            )
        ]

        XCTAssertEqual(desiredConstraints, layoutGuide.makeConstraints(.align(.leading)))
    }

    func testAlignX() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .leading,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .leading,
                multiplier: 1,
                constant: 0
            )
        ]

        XCTAssertEqual(desiredConstraints, view.makeConstraints(.align(.leading, .equal, to: .leading, of: containerView, multiplier: 1, offsetBy: 0)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.align(.leading, .equal, to: .leading, of: containerView, multiplier: 1)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.align(.leading, .equal, to: .leading, of: containerView)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.align(.leading, .equal, to: .leading)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.align(.leading, .equal)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.align(.leading)))
    }

    func testAlignY() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .top,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .top,
                multiplier: 1,
                constant: 0
            )
        ]

        XCTAssertEqual(desiredConstraints, view.makeConstraints(.align(.top, .equal, to: .top, of: containerView, multiplier: 1, offsetBy: 0)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.align(.top, .equal, to: .top, of: containerView, multiplier: 1)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.align(.top, .equal, to: .top, of: containerView)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.align(.top, .equal, to: .top)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.align(.top, .equal)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.align(.top)))
    }

    func testSetFixed() {
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

        XCTAssertEqual(desiredConstraints, view.makeConstraints(.setFixed(.width, .equal, to: 100)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.setFixed(.width, to: 100)))
    }

    func testSetRelative() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .width,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .width,
                multiplier: 1,
                constant: 0
            )
        ]

        XCTAssertEqual(desiredConstraints, view.makeConstraints(.setRelative(.width, .equal, to: 1, of: containerView, attribute: .width, constant: 0)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.setRelative(.width, .equal, to: 1, of: containerView, attribute: .width)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.setRelative(.width, .equal, to: 1, of: containerView)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.setRelative(.width, .equal, to: 1)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.setRelative(.width, .equal)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.setRelative(.width)))
    }

    func testSetSize() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 100
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 100
            )
        ]

        XCTAssertEqual(desiredConstraints, view.makeConstraints(.setSize(CGSize(width: 100, height: 100))))
    }

    func testPriorityAssignmentOperator() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .width,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .width,
                multiplier: 1,
                constant: 0
            )
        ]

        let priority = LayoutPriority.defaultHigh

        for constraint in desiredConstraints {
            constraint.priority = priority
        }

        XCTAssertEqual(desiredConstraints, view.makeConstraints(.setRelative(.width) ~ priority))
    }

    func testIdentifierOperator() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .width,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .width,
                multiplier: 1,
                constant: 0
            )
        ]

        let identifier = "hello"

        for constraint in desiredConstraints {
            constraint.identifier = identifier
        }

        XCTAssertEqual(desiredConstraints, view.makeConstraints(.setRelative(.width) <- identifier))
    }

    func testAlignToEdges() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .top,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .top,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .leading,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .leading,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .bottom,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .trailing,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .trailing,
                multiplier: 1,
                constant: 0
            )
        ]

        XCTAssertEqual(desiredConstraints, view.makeConstraints(.alignToEdges(of: containerView, top: 0, leading: 0, bottom: 0, trailing: 0)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.alignToEdges(of: containerView, top: 0, leading: 0, bottom: 0)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.alignToEdges(of: containerView, top: 0, leading: 0)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.alignToEdges(of: containerView, top: 0)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.alignToEdges(of: containerView)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.alignToEdges()))
    }

    func testCenter() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .centerX,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .centerY,
                multiplier: 1,
                constant: 0
            )
        ]

        XCTAssertEqual(desiredConstraints, view.makeConstraints(.center(in: containerView)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.center()))
    }

    func testMatchSize() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .width,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .width,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .height,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .height,
                multiplier: 1,
                constant: 0
            )
        ]

        XCTAssertEqual(desiredConstraints, view.makeConstraints(.matchSize(of: containerView, ratio: 1, constant: 0)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.matchSize(of: containerView, ratio: 1)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.matchSize(of: containerView)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.matchSize()))
    }

    func testActivate() {
        let constraints = view.makeConstraints(
            .matchSize()
            ).activate()

        XCTAssertTrue(constraints.count == 2)
        XCTAssertTrue(constraints.filter({ $0.isActive }).count == 2)
    }

    func testDeactivate() {
        let constraints = view.makeConstraints(
            .matchSize()
            ).deactivate()

        XCTAssertTrue(constraints.count == 2)
        XCTAssertTrue(constraints.filter({ !$0.isActive }).count == 2)
    }

    func testConstant() {
        let constraints = view.makeConstraints(
            .matchSize()
        )
        constraints.setConstant(100)

        XCTAssertTrue(constraints.count == 2)
        XCTAssertTrue(constraints.filter({ $0.constant == 100 }).count == 2)
    }

    func testAllLayoutAttributeMappings() {
        XCTAssertTrue(LayoutAttribute.leading == XPosition.leading.layoutAttribute)
        XCTAssertTrue(LayoutAttribute.trailing == XPosition.trailing.layoutAttribute)
        XCTAssertTrue(LayoutAttribute.centerX == XPosition.centerX.layoutAttribute)

        XCTAssertTrue(LayoutAttribute.top == YPosition.top.layoutAttribute)
        XCTAssertTrue(LayoutAttribute.bottom == YPosition.bottom.layoutAttribute)
        XCTAssertTrue(LayoutAttribute.centerY == YPosition.centerY.layoutAttribute)
        XCTAssertTrue(LayoutAttribute.firstBaseline == YPosition.firstBaseline.layoutAttribute)
        XCTAssertTrue(LayoutAttribute.lastBaseline == YPosition.lastBaseline.layoutAttribute)

        XCTAssertTrue(LayoutAttribute.width == Dimension.width.layoutAttribute)
        XCTAssertTrue(LayoutAttribute.height == Dimension.height.layoutAttribute)

        #if os(iOS) || os(tvOS)
        XCTAssertTrue(LayoutAttribute.topMargin == YPosition.topMargin.layoutAttribute)
        XCTAssertTrue(LayoutAttribute.bottomMargin == YPosition.bottomMargin.layoutAttribute)
        XCTAssertTrue(LayoutAttribute.centerYWithinMargins == YPosition.centerYWithinMargins.layoutAttribute)
        XCTAssertTrue(LayoutAttribute.leadingMargin == XPosition.leadingMargin.layoutAttribute)
        XCTAssertTrue(LayoutAttribute.trailingMargin == XPosition.trailingMargin.layoutAttribute)
        XCTAssertTrue(LayoutAttribute.centerXWithinMargins == XPosition.centerXWithinMargins.layoutAttribute)
        #endif
    }

    #if os(iOS) || os(tvOS)
    func testTraitCollectionConvenienceProperties() {
        XCTAssertEqual(UITraitCollection(horizontalSizeClass: .unspecified), .horizontallyUnspecified)
        XCTAssertEqual(UITraitCollection(verticalSizeClass: .unspecified), .verticallyUnspecified)
        XCTAssertEqual(UITraitCollection(horizontalSizeClass: .compact), .horizontallyCompact)
        XCTAssertEqual(UITraitCollection(horizontalSizeClass: .regular), .horizontallyRegular)
        XCTAssertEqual(UITraitCollection(verticalSizeClass: .compact), .verticallyCompact)
        XCTAssertEqual(UITraitCollection(verticalSizeClass: .regular), .verticallyRegular)
        XCTAssertEqual(UITraitCollection(userInterfaceIdiom: .pad), .isPad)
        XCTAssertEqual(UITraitCollection(userInterfaceIdiom: .phone), .isPhone)
        XCTAssertEqual(UITraitCollection(userInterfaceIdiom: .tv), .isTv)
        XCTAssertEqual(UITraitCollection(preferredContentSizeCategory: .large), .preferredContentSizeCategory(of: .large))
    }
    #endif

    func testApplyConstraints() {
        let constraints = view.applyConstraints(
            .matchSize()
        )

        XCTAssertTrue(constraints.count == 2)
        XCTAssertTrue(constraints.filter({ $0.isActive }).count == 2)
    }

    #if os(iOS) || os(tvOS)
    func testAlignToMargins() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .top,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .topMargin,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .leading,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .leadingMargin,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .bottomMargin,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .trailing,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .trailingMargin,
                multiplier: 1,
                constant: 0
            )
        ]

        XCTAssertEqual(desiredConstraints, view.makeConstraints(.alignToMargins(of: containerView, top: 0, leading: 0, bottom: 0, trailing: 0)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.alignToMargins(of: containerView, top: 0, leading: 0, bottom: 0)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.alignToMargins(of: containerView, top: 0, leading: 0)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.alignToMargins(of: containerView, top: 0)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.alignToMargins(of: containerView)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.alignToMargins()))
    }

    func testCenterWithinMargins() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .centerXWithinMargins,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .centerYWithinMargins,
                multiplier: 1,
                constant: 0
            )
        ]

        XCTAssertEqual(desiredConstraints, view.makeConstraints(.centerWithinMargins(of: containerView)))
        XCTAssertEqual(desiredConstraints, view.makeConstraints(.centerWithinMargins()))
    }
    #endif
}
