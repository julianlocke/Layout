/*
 The MIT License (MIT)

 Copyright (c) 2016 Cameron Pulsford

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

public struct LayoutDescriptor<Kind>: LayoutConstraintGenerator {
    public var attributes: [NSLayoutAttribute]
    public var relatedBy: NSLayoutRelation
    public var toItem: LayoutContainer?
    public var otherAttributes: [NSLayoutAttribute]?
    public var multiplier: CGFloat
    public var constant: CGFloat
    public var priority: UILayoutPriority?

    public init(
        _ attributes: [NSLayoutAttribute],
        relatedBy: NSLayoutRelation = .equal,
        toItem: LayoutContainer? = nil,
        otherAttributes: [NSLayoutAttribute]? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority? = nil
        ) {
        self.attributes = attributes
        self.relatedBy = relatedBy
        self.toItem = toItem
        self.otherAttributes = otherAttributes
        self.multiplier = multiplier
        self.constant = constant
        self.priority = priority
    }

    public init(_ other: LayoutDescriptor<Kind>, _ builder: (inout LayoutDescriptor<Kind>) -> ()) {
        var o = other
        builder(&o)
        attributes = o.attributes
        relatedBy = o.relatedBy
        toItem = o.toItem
        otherAttributes = o.otherAttributes
        multiplier = o.multiplier
        constant = o.constant
        priority = o.priority
    }

    public func constraints(for layoutContainer: LayoutContainer) -> [NSLayoutConstraint] {
        guard let superview = layoutContainer.superview else {
            fatalError("You must assign a superview before applying a layout.")
        }

        let otherAttributes = self.otherAttributes ?? attributes

        guard attributes.count == otherAttributes.count else {
            fatalError("Wrong number of other attributes specified.")
        }

        return zip(attributes, otherAttributes).map { attr, otherAttr in
            let toItem = otherAttr == .notAnAttribute ? nil : (self.toItem ?? superview)

            let constraint = NSLayoutConstraint(
                item: layoutContainer,
                attribute: attr,
                relatedBy: relatedBy,
                toItem: toItem,
                attribute: otherAttr,
                multiplier: multiplier,
                constant: constant
            )

            if let priority = priority {
                constraint.priority = priority
            }

            return constraint
        }
    }
}
