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

#if os(macOS)
    import AppKit
#else
    import UIKit
#endif

public struct ConstraintSpec: ConstraintCreating {

    public var firstAttribute: LayoutAttribute

    public var relation: LayoutRelation

    public var secondItem: ConstrainableItem?

    public var secondAttribute: LayoutAttribute

    public var multiplier: CGFloat

    public var constant: CGFloat

    public init(
        attribute firstAttr: LayoutAttribute,
        relatedBy relation: LayoutRelation = .equal,
        toItem item: ConstrainableItem? = nil,
        attribute secondAttr: LayoutAttribute,
        multiplier: CGFloat = 0,
        constant: CGFloat = 0) {
        self.firstAttribute = firstAttr
        self.relation = relation
        self.secondItem = item
        self.secondAttribute = secondAttr
        self.multiplier = multiplier
        self.constant = constant
    }

    public func constraint(withItem firstItem: ConstrainableItem) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondAttribute == .notAnAttribute ? nil : (secondItem ?? firstItem.parentView),
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant
        )
    }
}

private extension ConstrainableItem {

    var parentView: View? {
        return (self as? View).flatMap { $0.superview } ?? (self as? LayoutGuide).flatMap { $0.owningView }
    }
}
