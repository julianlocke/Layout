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

public struct AnchorLayoutDescriptor<AnchorKind: AnyObject>: LayoutConstraintGenerator {

    var firstAnchor: NSLayoutAnchor<AnchorKind>

    var secondAnchor: NSLayoutAnchor<AnchorKind>

    public var relation: LayoutRelation

    public var constant: CGFloat?

    public var priority: LayoutPriority?

    public var identifier: String?

    public init(
        firstAnchor: NSLayoutAnchor<AnchorKind>,
        secondAnchor: NSLayoutAnchor<AnchorKind>,
        relation: LayoutRelation,
        constant: CGFloat? = nil,
        priority: LayoutPriority? = nil,
        identifier: String? = nil
        ) {
        self.firstAnchor = firstAnchor
        self.secondAnchor = secondAnchor
        self.relation = relation
        self.constant = constant
        self.priority = priority
        self.identifier = identifier
    }

    public func constraints(for container: ConstraintContainer) -> [NSLayoutConstraint] {
        return [constraint()]
    }

    public func constraint() -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint

        switch relation {
        case .lessThanOrEqual:
            constraint = firstAnchor.constraint(lessThanOrEqualTo: secondAnchor)
        case .equal:
            constraint = firstAnchor.constraint(equalTo: secondAnchor)
        case .greaterThanOrEqual:
            constraint = firstAnchor.constraint(greaterThanOrEqualTo: secondAnchor)
        }

        if let constant = constant {
            constraint.constant = constant
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

extension AnchorLayoutDescriptor {

    func modify(_ builder: (inout AnchorLayoutDescriptor<AnchorKind>) -> Void) -> AnchorLayoutDescriptor<AnchorKind> {
        var result = self
        builder(&result)
        return result
    }
}
