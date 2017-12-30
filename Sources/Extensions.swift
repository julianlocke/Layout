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

public extension Array where Element == NSLayoutConstraint {

    @discardableResult
    func activate() -> [NSLayoutConstraint] {
        NSLayoutConstraint.activate(self)
        return self
    }

    @discardableResult
    func deactivate() -> [NSLayoutConstraint] {
        NSLayoutConstraint.deactivate(self)
        return self
    }

    func setConstant(_ constant: CGFloat) {
        for constraint in self {
            constraint.constant = constant
        }
    }
}

public extension UITraitCollection {

    static var horizontallyUnspecified: UITraitCollection {
        return UITraitCollection(horizontalSizeClass: .unspecified)
    }

    static var verticallyUnspecified: UITraitCollection {
        return UITraitCollection(verticalSizeClass: .unspecified)
    }

    static var horizontallyCompact: UITraitCollection {
        return UITraitCollection(horizontalSizeClass: .compact)
    }

    static var horizontallyRegular: UITraitCollection {
        return UITraitCollection(horizontalSizeClass: .regular)
    }

    static var verticallyCompact: UITraitCollection {
        return UITraitCollection(verticalSizeClass: .compact)
    }

    static var verticallyRegular: UITraitCollection {
        return UITraitCollection(verticalSizeClass: .regular)
    }

    static var isPad: UITraitCollection {
        return UITraitCollection(userInterfaceIdiom: .pad)
    }

    static var isPhone: UITraitCollection {
        return UITraitCollection(userInterfaceIdiom: .phone)
    }

    static var isTv: UITraitCollection {
        return UITraitCollection(userInterfaceIdiom: .tv)
    }

    static func preferredContentSizeCategory(of contentSizeCategory: UIContentSizeCategory) -> UITraitCollection {
        return UITraitCollection(preferredContentSizeCategory: contentSizeCategory)
    }
}
