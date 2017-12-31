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

public struct ConstraintGroup: ExpressibleByArrayLiteral {

    internal var specs: [ConstraintSpec] = []

    public var priority: LayoutPriority = .required

    public var identifier: String?

    public init(specs: [ConstraintSpec]) {
        self.specs = specs
    }

    public init(arrayLiteral elements: ConstraintGroup...) {
        self.specs = elements.flatMap { $0.specs }
    }

    public func constraints(withItem firstItem: ConstrainableItem) -> [NSLayoutConstraint] {
        return specs.map {
            let constraint = $0.constraint(withItem: firstItem)
            constraint.priority = priority
            constraint.identifier = identifier
            return constraint
        }
    }
}

public extension ConstraintGroup {

    static func with(_ specs: ConstraintSpec...) -> ConstraintGroup {
        return ConstraintGroup(specs: specs)
    }

    static func constraint(
        attribute firstAttr: LayoutAttribute,
        relatedBy relation: LayoutRelation = .equal,
        toItem item: ConstrainableItem? = nil,
        attribute secondAttr: LayoutAttribute = .notAnAttribute,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0) -> ConstraintGroup {
        return with(ItemConstraintSpec(
            attribute: firstAttr,
            relatedBy: relation,
            toItem: item,
            attribute: secondAttr,
            multiplier: multiplier,
            constant: constant
        ))
    }

    static func align(_ firstAttr: XPosition, _ relation: LayoutRelation = .equal, to secondAttr: XPosition? = nil, of item: ConstrainableItem? = nil, multiplier: CGFloat = 1, offsetBy: CGFloat = 0) -> ConstraintGroup {
        return constraint(
            attribute: firstAttr.layoutAttribute,
            relatedBy: relation,
            toItem: item,
            attribute: (secondAttr ?? firstAttr).layoutAttribute,
            multiplier: multiplier,
            constant: offsetBy
        )
    }

    static func align(_ firstAttr: YPosition, _ relation: LayoutRelation = .equal, to secondAttr: YPosition? = nil, of item: ConstrainableItem? = nil, multiplier: CGFloat = 1, offsetBy: CGFloat = 0) -> ConstraintGroup {
        return constraint(
            attribute: firstAttr.layoutAttribute,
            relatedBy: relation,
            toItem: item,
            attribute: (secondAttr ?? firstAttr).layoutAttribute,
            multiplier: multiplier,
            constant: offsetBy
        )
    }

    static func setFixed(_ firstAttr: Dimension, _ relation: LayoutRelation = .equal, to constant: CGFloat) -> ConstraintGroup {
        return constraint(
            attribute: firstAttr.layoutAttribute,
            relatedBy: relation,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: constant
        )
    }

    static func setRelative(_ firstAttr: Dimension, _ relation: LayoutRelation = .equal, to multiplier: CGFloat = 1, of item: ConstrainableItem? = nil, attribute secondAttr: Dimension? = nil, constant: CGFloat = 0) -> ConstraintGroup {
        return constraint(
            attribute: firstAttr.layoutAttribute,
            relatedBy: relation,
            toItem: item,
            attribute: (secondAttr ?? firstAttr).layoutAttribute,
            multiplier: multiplier,
            constant: constant
        )
    }
}
