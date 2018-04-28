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

public extension Array where Element == NSLayoutConstraint {

    /// Activates an `Array` of `NSLayoutConstraint`s and returns them.
    ///
    /// - Returns: An activated `Array` of `NSLayoutConstraint`s.
    @discardableResult
    func activate() -> [NSLayoutConstraint] {
        NSLayoutConstraint.activate(self)
        return self
    }

    /// Deactivates an `Array` of `NSLayoutConstraint`s and returns them.
    ///
    /// - Returns: A deactivated `Array` of `NSLayoutConstraint`s.
    @discardableResult
    func deactivate() -> [NSLayoutConstraint] {
        NSLayoutConstraint.deactivate(self)
        return self
    }

    /// Set the `constant` property of all the `NSLayoutConstraint`s in the receving `Array`.
    ///
    /// - Parameter constant: The constant.
    func setConstant(_ constant: CGFloat) {
        for constraint in self {
            constraint.constant = constant
        }
    }
}

#if os(iOS) || os(tvOS)
public extension UITraitCollection {

    /// Returns a new trait collection representing an unspecified horizontal size class.
    static var horizontallyUnspecified: UITraitCollection {
        return UITraitCollection(horizontalSizeClass: .unspecified)
    }

    /// Returns a new trait collection representing a compact horizontal size class.
    static var horizontallyCompact: UITraitCollection {
        return UITraitCollection(horizontalSizeClass: .compact)
    }

    /// Returns a new trait collection representing a regular horizontal size class.
    static var horizontallyRegular: UITraitCollection {
        return UITraitCollection(horizontalSizeClass: .regular)
    }

    /// Returns a new trait collection representing an unspecified vertical size class.
    static var verticallyUnspecified: UITraitCollection {
        return UITraitCollection(verticalSizeClass: .unspecified)
    }

    /// Returns a new trait collection representing a compact vertical size class.
    static var verticallyCompact: UITraitCollection {
        return UITraitCollection(verticalSizeClass: .compact)
    }

    /// Returns a new trait collection representing a regular vertical size class.
    static var verticallyRegular: UITraitCollection {
        return UITraitCollection(verticalSizeClass: .regular)
    }

    /// Returns a new trait collection representing an iPad user interface idiom.
    static var isPad: UITraitCollection {
        return UITraitCollection(userInterfaceIdiom: .pad)
    }

    /// Returns a new trait collection representing an iPhone user interface idiom.
    static var isPhone: UITraitCollection {
        return UITraitCollection(userInterfaceIdiom: .phone)
    }

    /// Returns a new trait collection representing a tv user interface idiom.
    static var isTv: UITraitCollection {
        return UITraitCollection(userInterfaceIdiom: .tv)
    }

    /// Returns a new trait collection representing a specific content size category.
    ///
    /// - Parameter contentSizeCategory: The content size category.
    /// - Returns: A new trait collection representing a specific content size category.
    static func preferredContentSizeCategory(of contentSizeCategory: UIContentSizeCategory) -> UITraitCollection {
        return UITraitCollection(preferredContentSizeCategory: contentSizeCategory)
    }
}
#endif
