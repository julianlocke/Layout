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

precedencegroup LayoutAssignment {
    associativity: left
    lowerThan: ComparisonPrecedence
}

infix operator ~ : LayoutAssignment

public func ~ <Kind>(lhs: LayoutDescriptor<Kind>, rhs: UILayoutPriority) -> LayoutDescriptor<Kind> {
    var result = lhs
    result.priority = rhs
    return result
}

public func == <Kind>(lhs: LayoutDescriptor<Kind>, rhs: LayoutDescriptor<Kind>) -> LayoutDescriptor<Kind> {
    return lhs.modify { result in
        result.toItem = rhs.toItem
        result.otherAttributes = rhs.attributes
        result.constant = rhs.constant
        result.multiplier = rhs.multiplier
    }
}

public func == <Kind>(lhs: LayoutDescriptor<Kind>, rhs: LayoutContainer) -> LayoutDescriptor<Kind> {
    var result = lhs
    result.toItem = rhs
    return result
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
    var result = lhs
    result.constant = rhs
    return result
}

public func - <Kind>(lhs: LayoutDescriptor<Kind>, rhs: CGFloat) -> LayoutDescriptor<Kind> {
    var result = lhs
    result.constant = -rhs
    return result
}

public func * <Kind>(lhs: LayoutDescriptor<Kind>, rhs: CGFloat) -> LayoutDescriptor<Kind> {
    var result = lhs
    result.multiplier = rhs
    return result
}

public func / <Kind>(lhs: LayoutDescriptor<Kind>, rhs: CGFloat) -> LayoutDescriptor<Kind> {
    var result = lhs
    result.multiplier = 1 / rhs
    return result
}
