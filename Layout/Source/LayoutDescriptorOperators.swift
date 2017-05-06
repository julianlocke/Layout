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

precedencegroup LayoutPriorityAssignment {
    associativity: left
    lowerThan: ComparisonPrecedence
    higherThan: LayoutIdentifierAssignment
}

infix operator ~ : LayoutPriorityAssignment

public func ~ <Kind>(lhs: LayoutDescriptor<Kind>, rhs: LayoutPriority) -> LayoutDescriptor<Kind> {
    return lhs.modify { result in
        result.priority = rhs
    }
}

precedencegroup LayoutIdentifierAssignment {
    associativity: left
}

infix operator <- : LayoutIdentifierAssignment

public func <- <Kind>(lhs: LayoutDescriptor<Kind>, rhs: String) -> LayoutDescriptor<Kind> {
    return lhs.modify { result in
        result.identifier = rhs
    }
}

public func == <Kind>(lhs: LayoutDescriptor<Kind>, rhs: LayoutDescriptor<Kind>) -> LayoutDescriptor<Kind> {
    return lhs.modify { result in
        result.toItem = rhs.toItem
        result.otherAttributes = rhs.attributes
        result.constant = rhs.constant
        result.multiplier = rhs.multiplier
    }
}

public func == <Kind>(lhs: LayoutDescriptor<Kind>, rhs: ConstraintContainer) -> LayoutDescriptor<Kind> {
    return lhs.modify { result in
        result.toItem = rhs
    }
}

public func == <Kind>(lhs: LayoutDescriptor<Kind>, rhs: CGFloat) -> LayoutDescriptor<Kind> {
    return lhs.modify { result in
        result.constant = rhs
        result.otherAttributes = [NSLayoutAttribute](repeatElement(.notAnAttribute, count: result.attributes.count))
    }
}

public func >= <Kind>(lhs: LayoutDescriptor<Kind>, rhs: LayoutDescriptor<Kind>) -> LayoutDescriptor<Kind> {
    return lhs.modify { result in
        result.toItem = rhs.toItem
        result.relatedBy = .greaterThanOrEqual
        result.otherAttributes = rhs.attributes
        result.constant = rhs.constant
        result.multiplier = rhs.multiplier
    }
}

public func >= <Kind>(lhs: LayoutDescriptor<Kind>, rhs: CGFloat) -> LayoutDescriptor<Kind> {
    return lhs.modify { result in
        result.constant = rhs
        result.multiplier = 1
        result.relatedBy = .greaterThanOrEqual
        result.otherAttributes = [NSLayoutAttribute](repeatElement(.notAnAttribute, count: result.attributes.count))
    }
}

public func <= <Kind>(lhs: LayoutDescriptor<Kind>, rhs: LayoutDescriptor<Kind>) -> LayoutDescriptor<Kind> {
    return lhs.modify { result in
        result.toItem = rhs.toItem
        result.relatedBy = .lessThanOrEqual
        result.otherAttributes = rhs.attributes
        result.constant = rhs.constant
        result.multiplier = rhs.multiplier
    }
}

public func <= <Kind>(lhs: LayoutDescriptor<Kind>, rhs: CGFloat) -> LayoutDescriptor<Kind> {
    return lhs.modify { result in
        result.constant = rhs
        result.multiplier = 1
        result.relatedBy = .lessThanOrEqual
        result.otherAttributes = [NSLayoutAttribute](repeatElement(.notAnAttribute, count: result.attributes.count))
    }
}

public func + <Kind>(lhs: LayoutDescriptor<Kind>, rhs: CGFloat) -> LayoutDescriptor<Kind> {
    return lhs.modify { result in
        if let constant = result.constant {
            result.constant = constant + rhs
        } else if let constants = result.constants {
            result.constants = constants.map({ $0 + rhs })
        } else {
            result.constant = rhs
        }
    }
}

public func - <Kind>(lhs: LayoutDescriptor<Kind>, rhs: CGFloat) -> LayoutDescriptor<Kind> {
    return lhs.modify { result in
        if let constant = result.constant {
            result.constant = constant - rhs
        } else if let constants = result.constants {
            result.constants = constants.map({ $0 - rhs })
        } else {
            result.constant = -rhs
        }
    }
}

public func * <Kind>(lhs: LayoutDescriptor<Kind>, rhs: CGFloat) -> LayoutDescriptor<Kind> {
    return lhs.modify { result in
        result.multiplier = rhs
    }
}

public func / <Kind>(lhs: LayoutDescriptor<Kind>, rhs: CGFloat) -> LayoutDescriptor<Kind> {
    return lhs.modify { result in
        result.multiplier = 1 / rhs
    }
}
