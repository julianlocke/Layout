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
    import Cocoa
#else
    import UIKit
#endif

public protocol LayoutConstraintGenerator {

    func constraints(for container: ConstraintContainer) -> [NSLayoutConstraint]
}

public struct LayoutDescriptor<Kind>: LayoutConstraintGenerator {

    public var attributes: [LayoutAttribute]

    public var relatedBy: LayoutRelation

    public var toItem: ConstraintContainer?

    public var otherAttributes: [LayoutAttribute]?

    public var multiplier: CGFloat

    public var constant: CGFloat?

    public var constants: [CGFloat]?

    public var priority: LayoutPriority?

    public var reinterpretConstants: Bool

    public var identifier: String?

    public init(
        _ attributes: [LayoutAttribute],
        relatedBy: LayoutRelation = .equal,
        toItem: ConstraintContainer? = nil,
        otherAttributes: [LayoutAttribute]? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat? = nil,
        constants: [CGFloat]? = nil,
        priority: LayoutPriority? = nil,
        reinterpretConstants: Bool = false
        ) {
        self.attributes = attributes
        self.relatedBy = relatedBy
        self.toItem = toItem
        self.otherAttributes = otherAttributes
        self.multiplier = multiplier
        self.constant = constant
        self.constants = constants
        self.priority = priority
        self.reinterpretConstants = reinterpretConstants
    }

    public func constraints(for container: ConstraintContainer) -> [NSLayoutConstraint] {
        guard let superview = container.parentView else {
            fatalError("You must assign a superview before applying a layout.")
        }

        let otherAttributes = self.otherAttributes ?? attributes

        guard attributes.count == otherAttributes.count else {
            fatalError("Wrong number of other attributes specified.")
        }

        let constants: [CGFloat]

        if let c = constant {
            constants = [CGFloat](repeatElement(c, count: attributes.count))
        } else if let cs = self.constants {
            constants = cs
        } else {
            constants = [CGFloat](repeatElement(0, count: attributes.count))
        }

        guard constants.count == otherAttributes.count else {
            fatalError("Wrong number of constants specified.")
        }

        return zip3(attributes, otherAttributes, constants).map { value in
            let (attr, otherAttr, constant) = value

            let toItem = otherAttr == .notAnAttribute ? nil : (self.toItem ?? superview)

            let constraint = NSLayoutConstraint(
                item: container,
                attribute: attr,
                relatedBy: relatedBy,
                toItem: toItem,
                attribute: otherAttr,
                multiplier: otherAttr == .notAnAttribute ? 0 : multiplier,
                constant: reinterpret(constant: constant, for: attr)
            )

            constraint.identifier = identifier

            if let priority = priority {
                constraint.priority = priority
            }

            return constraint
        }
    }

    public func constraint() -> NSLayoutConstraint {
        var copy = self

        guard let container = copy.toItem else {
            fatalError("A ConstraintContainer must be specified.")
        }

        if let view = container as? View {
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        copy.toItem = nil
        let constraints = copy.constraints(for: container)

        guard constraints.count == 1 else {
            fatalError("You must specify a layout that only produces a single constraint.")
        }

        return constraints[0]
    }
}

extension LayoutDescriptor {

    func modify(_ builder: (inout LayoutDescriptor<Kind>) -> Void) -> LayoutDescriptor<Kind> {
        var result = self
        builder(&result)
        return result
    }
}

fileprivate extension LayoutDescriptor {

    func reinterpret(constant: CGFloat, for attribute: LayoutAttribute) -> CGFloat {
        guard reinterpretConstants, attribute.requiresReinterpretation else {
            return constant
        }

        return constant * -1
    }
}
