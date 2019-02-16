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

public struct ConstraintGroup {

    public static var debugConstraints = false

    var specs: [ConstraintSpec]

    public var priority: UILayoutPriority = .required

    public var identifier: String?

    init(spec: ConstraintSpec) {
        self.specs = [spec]
    }

    init(specs: [ConstraintSpec]) {
        self.specs = specs
    }

    public init(composedOf groups: [ConstraintGroup]) {
        self.specs = groups.flatMap { $0.specs }
    }

    func constraints(withItem item: ConstrainableItem) -> [NSLayoutConstraint] {
        return specs.map { spec in
            let constraint = spec.constraint(withItem: item)
            constraint.priority = priority
            constraint.identifier = identifier
            return constraint
        }
    }

    static func singleConstraint(
        attribute1: NSLayoutConstraint.Attribute,
        relation: NSLayoutConstraint.Relation,
        item2: ConstraintSpec.SecondItem?,
        attribute2: NSLayoutConstraint.Attribute,
        multiplier: CGFloat,
        constant: CGFloat,
        file: StaticString,
        function: StaticString,
        line: Int
        ) -> ConstraintGroup {
        var group: ConstraintGroup = .init(spec:
            .init(
                attribute1: attribute1,
                relation: relation,
                item2: item2,
                attribute2: attribute2,
                multiplier: multiplier,
                constant: constant
            )
        )
        if debugConstraints {
            group.identifier = "\(file)::\(function)::\(line)"
        }
        return group
    }

    public static func align(
        _ firstAttr: XAttribute,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to secondAttr: XAttribute? = nil,
        of item: ConstrainableItem? = nil,
        multiplier: CGFloat = 1,
        offsetBy offset: CGFloat = 0,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line
        ) -> ConstraintGroup {
        return singleConstraint(
            attribute1: firstAttr.attribute,
            relation: relation,
            item2: item == nil ? .parent : .other(item!),
            attribute2: (secondAttr ?? firstAttr).attribute,
            multiplier: multiplier,
            constant: offset,
            file: file,
            function: function,
            line: line
        )
    }

    public static func align(
        _ firstAttr: YAttribute,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to secondAttr: YAttribute? = nil,
        of item: ConstrainableItem? = nil,
        multiplier: CGFloat = 1,
        offsetBy offset: CGFloat = 0,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line
        ) -> ConstraintGroup {
        return singleConstraint(
            attribute1: firstAttr.attribute,
            relation: relation,
            item2: item == nil ? .parent : .other(item!),
            attribute2: (secondAttr ?? firstAttr).attribute,
            multiplier: multiplier,
            constant: offset,
            file: file,
            function: function,
            line: line
        )
    }

    public static func setFixed
        (
        _ firstAttr: DimensionAttribute,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to constant: CGFloat,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line
        )
        -> ConstraintGroup {
            return singleConstraint(
                attribute1: firstAttr.attribute,
                relation: relation,
                item2: nil,
                attribute2: .notAnAttribute,
                multiplier: 1,
                constant: constant,
                file: file,
                function: function,
                line: line
            )
    }

    public static func setRelative
        (
        _ firstAttr: DimensionAttribute,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to multiplier: CGFloat = 1,
        of item: ConstrainableItem? = nil,
        attribute secondAttr: DimensionAttribute? = nil,
        constant: CGFloat = 0,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line
        )
        -> ConstraintGroup {
            return singleConstraint(
                attribute1: firstAttr.attribute,
                relation: relation,
                item2: item == nil ? .parent : .other(item!),
                attribute2: (secondAttr ?? firstAttr).attribute,
                multiplier: multiplier,
                constant: constant,
                file: file,
                function: function,
                line: line
            )
    }
}
