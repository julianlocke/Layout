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

#if os(macOS)
import AppKit
#else
import UIKit
#endif

import Layout

func == (lhs: NSLayoutConstraint, rhs: NSLayoutConstraint) -> Bool {
    return lhs.firstItem === rhs.firstItem &&
        lhs.firstAttribute == rhs.firstAttribute &&
        lhs.secondItem === rhs.secondItem &&
        lhs.secondAttribute == rhs.secondAttribute &&
        lhs.relation == rhs.relation &&
        lhs.multiplier == rhs.multiplier &&
        lhs.constant == rhs.constant &&
        lhs.priority == rhs.priority &&
        lhs.identifier == rhs.identifier
}

extension NSLayoutConstraint {

    // swiftlint:disable:next override_in_extension
    open override func isEqual(_ object: Any?) -> Bool {
        guard let otherConstraint = object as? NSLayoutConstraint else { return false }
        return self.firstItem === otherConstraint.firstItem &&
            self.firstAttribute == otherConstraint.firstAttribute &&
            self.secondItem === otherConstraint.secondItem &&
            self.secondAttribute == otherConstraint.secondAttribute &&
            self.relation == otherConstraint.relation &&
            self.multiplier == otherConstraint.multiplier &&
            self.constant == otherConstraint.constant &&
            self.priority == otherConstraint.priority &&
            self.identifier == otherConstraint.identifier
    }
}

extension Layout {

    func updateTraits(_ givenTraits: [UITraitCollection]) {
        updateTraits(UITraitCollection(traitsFrom: givenTraits))
    }
}
