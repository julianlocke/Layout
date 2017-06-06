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

import UIKit

public extension Sequence where Iterator.Element == UITraitCollection {

    /// Merges a sequence of `UITraitCollection`s into a single `UITraitCollection`.
    ///
    /// - Returns: A `UITraitCollection` that is the result of merging all of the `Sequence`'s elements.
    func merged() -> UITraitCollection {
        return UITraitCollection(traitsFrom: Array(self))
    }
}

/// Combine two `UITraitCollection`s into a single `UITraitCollection`.
///
/// - Parameters:
///   - lhs: The left trait collection
///   - rhs: The right trait collection
/// - Returns: A single `UITraitCollection` that is the result of merging two `UITraitCollection`s.
public func && (lhs: UITraitCollection, rhs: UITraitCollection) -> UITraitCollection {
    return [lhs, rhs].merged()
}

public extension UITraitCollection {

    /// Returns a new `UITraitCollection` containing the given interface idiom.
    ///
    /// - Parameter idiom: The interface idiom.
    /// - Returns: A new `UITraitCollection` containing the given interface idiom.
    static func idiom(_ idiom: UIUserInterfaceIdiom) -> UITraitCollection {
        return UITraitCollection(userInterfaceIdiom: idiom)
    }

    /// Returns a new `UITraitCollection` containing the given horizontal size class.
    ///
    /// - Parameter idiom: The horizontal size class.
    /// - Returns: A new `UITraitCollection` containing the given horizontal size class.
    static func horizontally(_ sizeClass: UIUserInterfaceSizeClass) -> UITraitCollection {
        return UITraitCollection(horizontalSizeClass: sizeClass)
    }

    /// Returns a new `UITraitCollection` containing the given vertical size class.
    ///
    /// - Parameter idiom: The horizontal size class.
    /// - Returns: A new `UITraitCollection` containing the given vertical size class.
    static func vertically(_ sizeClass: UIUserInterfaceSizeClass) -> UITraitCollection {
        return UITraitCollection(verticalSizeClass: sizeClass)
    }
}
