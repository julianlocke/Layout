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

public extension ConstraintSpecGroup {

    static func alignToEdges(of item: ConstrainableItem? = nil, top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) -> ConstraintSpecGroup {
        return [
            .align(.top, of: item, offsetBy: top),
            .align(.leading, of: item, offsetBy: leading),
            .align(.bottom, of: item, offsetBy: bottom),
            .align(.trailing, of: item, offsetBy: trailing)
        ]
    }

    static func center(in item: ConstrainableItem? = nil) -> ConstraintSpecGroup {
        return [
            .align(.centerX, of: item),
            .align(.centerY, of: item)
        ]
    }

    static func matchSize(of item: ConstrainableItem? = nil, ratio: CGFloat = 1, constant: CGFloat = 0) -> ConstraintSpecGroup {
        return [
            .setRelative(.width, to: ratio, of: item, constant: constant),
            .setRelative(.height, to: ratio, of: item, constant: constant)
        ]
    }

    static func setSize(_ size: CGSize) -> ConstraintSpecGroup {
        return [
        .setFixed(.width, to: size.width),
        .setFixed(.height, to: size.height)
        ]
    }

    #if os(iOS) || os(tvOS)
    static func centerWithinMargins(of item: ConstrainableItem? = nil) -> ConstraintSpecGroup {
        return [
            .align(.centerX, to: .centerXWithinMargins, of: item),
            .align(.centerY, to: .centerYWithinMargins, of: item)
        ]
    }

    static func alignToMargins(of item: ConstrainableItem? = nil, top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) -> ConstraintSpecGroup {
        return [
            .align(.top, to: .topMargin, of: item, offsetBy: top),
            .align(.leading, to: .leadingMargin, of: item, offsetBy: leading),
            .align(.bottom, to: .bottomMargin, of: item, offsetBy: bottom),
            .align(.trailing, to: .trailingMargin, of: item, offsetBy: trailing)
        ]
    }
    #endif
}
