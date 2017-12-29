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

public extension Layout {

    static func alignToEdges(of container: ConstraintContainer? = nil, top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) -> Layout {
        return [
            .align(.top, of: container, constant: top),
            .align(.leading, of: container, constant: leading),
            .align(.bottom, of: container, constant: bottom),
            .align(.trailing, of: container, constant: trailing)
        ]
    }

    static func center(in container: ConstraintContainer? = nil) -> Layout {
        return [
            .align(.centerX, of: container),
            .align(.centerY, of: container)
        ]
    }

    static func matchSize(of container: ConstraintContainer? = nil, ratio: CGFloat = 1, constant: CGFloat = 0) -> Layout {
        return [
            .setRelative(.width, to: ratio, of: container, constant: constant),
            .setRelative(.height, to: ratio, of: container, constant: constant)
        ]
    }

    #if os(iOS) || os(tvOS)
    static func centerWithinMargins(of container: ConstraintContainer? = nil) -> Layout {
        return [
            .align(.centerX, to: .centerXWithinMargins, of: container),
            .align(.centerY, to: .centerYWithinMargins, of: container)
        ]
    }

    static func alignToMargins(of container: ConstraintContainer? = nil, top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) -> Layout {
        return [
            .align(.top, to: .topMargin, of: container, constant: top),
            .align(.leading, to: .leadingMargin, of: container, constant: leading),
            .align(.bottom, to: .bottomMargin, of: container, constant: bottom),
            .align(.trailing, to: .trailingMargin, of: container, constant: trailing)
        ]
    }
    #endif
}
