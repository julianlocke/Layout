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

public struct DimensionLayoutDescriptor: LayoutConstraintGenerator {

    var firstDimension: NSLayoutDimension

    var secondDimension: NSLayoutDimension?

    public var relation: LayoutRelation

    public var multiplier: CGFloat?

    public var constant: CGFloat?

    public var priority: LayoutPriority?

    public var identifier: String?

    public init(
        firstDimension: NSLayoutDimension,
        secondDimension: NSLayoutDimension? = nil,
        relation: LayoutRelation,
        multiplier: CGFloat? = nil,
        constant: CGFloat? = nil,
        priority: LayoutPriority? = nil,
        identifier: String? = nil
        ) {
        self.firstDimension = firstDimension
        self.secondDimension = secondDimension
        self.relation = relation
        self.multiplier = multiplier
        self.constant = constant
        self.priority = priority
        self.identifier = identifier
    }

    public func constraints(for container: ConstraintContainer) -> [NSLayoutConstraint] {
        return [constraint()]
    }

    // swiftlint:disable:next cyclomatic_complexity
    public func constraint() -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint

        if let secondDimension = secondDimension {
            if let multiplier = multiplier {
                switch relation {
                case .lessThanOrEqual:
                    constraint = firstDimension.constraint(lessThanOrEqualTo: secondDimension, multiplier: multiplier)
                case .equal:
                    constraint = firstDimension.constraint(equalTo: secondDimension, multiplier: multiplier)
                case .greaterThanOrEqual:
                    constraint = firstDimension.constraint(greaterThanOrEqualTo: secondDimension, multiplier: multiplier)
                }
            } else {
                switch relation {
                case .lessThanOrEqual:
                    constraint = firstDimension.constraint(lessThanOrEqualTo: secondDimension)
                case .equal:
                    constraint = firstDimension.constraint(equalTo: secondDimension)
                case .greaterThanOrEqual:
                    constraint = firstDimension.constraint(greaterThanOrEqualTo: secondDimension)
                }
            }

            if let constant = constant {
                constraint.constant = constant
            }
        } else {
            guard let constant = constant else {
                fatalError("Must specify a constant when not specifying a second dimension.")
            }

            switch relation {
            case .lessThanOrEqual:
                constraint = firstDimension.constraint(lessThanOrEqualToConstant: constant)
            case .equal:
                constraint = firstDimension.constraint(equalToConstant: constant)
            case .greaterThanOrEqual:
                constraint = firstDimension.constraint(greaterThanOrEqualToConstant: constant)
            }
        }

        if let priority = priority {
            constraint.priority = priority
        }

        if let identifier = identifier {
            constraint.identifier = identifier
        }

        return constraint
    }
}

extension DimensionLayoutDescriptor {

    func modify(_ builder: (inout DimensionLayoutDescriptor) -> Void) -> DimensionLayoutDescriptor {
        var result = self
        builder(&result)
        return result
    }
}
