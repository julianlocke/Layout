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

// MARK: - Left/leading layouts

public extension Layout {

    public static let leftMargin = LayoutDescriptor<XLayout>([.leftMargin])

    public static func leftMargin(of container: ConstraintContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.leftMargin], toItem: container)
    }

    public static let leftToMargin = LayoutDescriptor<XLayout>([.left], otherAttributes: [.leftMargin])

    public static let leadingMargin = LayoutDescriptor<NaturalXLayout>([.leadingMargin])

    public static func leadingMargin(of container: ConstraintContainer) -> LayoutDescriptor<NaturalXLayout> {
        return LayoutDescriptor([.leadingMargin], toItem: container)
    }

    public static let leadingToMargin = LayoutDescriptor<NaturalXLayout>([.leading], otherAttributes: [.leadingMargin])
}

// MARK: - Right/trailing layouts

public extension Layout {

    public static let rightMargin = LayoutDescriptor<XLayout>([.rightMargin])

    public static func rightMargin(of container: ConstraintContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.rightMargin], toItem: container)
    }

    public static let rightToMargin = LayoutDescriptor<XLayout>([.right], otherAttributes: [.rightMargin])

    public static let trailingMargin = LayoutDescriptor<NaturalXLayout>([.trailingMargin])

    public static func trailingMargin(of container: ConstraintContainer) -> LayoutDescriptor<NaturalXLayout> {
        return LayoutDescriptor([.trailingMargin], toItem: container)
    }

    public static let trailingToMargin = LayoutDescriptor<NaturalXLayout>([.trailing], otherAttributes: [.trailingMargin])
}

// MARK: - Top/baseline layouts

public extension Layout {

    public static let topMargin = LayoutDescriptor<YLayout>([.topMargin])

    public static func topMargin(of container: ConstraintContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.topMargin], toItem: container)
    }

    public static let topToMargin = LayoutDescriptor<YLayout>([.top], otherAttributes: [.topMargin])
}

// MARK: - Bottom/baseline layouts

public extension Layout {

    public static let bottomMargin = LayoutDescriptor<YLayout>([.bottomMargin])

    public static func bottomMargin(of container: ConstraintContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.bottomMargin], toItem: container)
    }

    public static let bottomToMargin = LayoutDescriptor<YLayout>([.bottom], otherAttributes: [.bottomMargin])
}

// MARK: - Center x layouts

public extension Layout {

    public static let centerXWithinMargins = LayoutDescriptor<XLayout>([.centerXWithinMargins])

    public static func centerXWithinMargins(of container: ConstraintContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.centerXWithinMargins], toItem: container)
    }

    public static let centerToXWithinMargins = LayoutDescriptor<XLayout>([.centerX], otherAttributes: [.centerXWithinMargins])
}

// MARK: - Center y layouts

public extension Layout {

    public static let centerYWithinMargins = LayoutDescriptor<YLayout>([.centerYWithinMargins])

    public static func centerYWithinMargins(of container: ConstraintContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.centerYWithinMargins], toItem: container)
    }

    public static let centerToYWithinMargins = LayoutDescriptor<YLayout>([.centerY], otherAttributes: [.centerYWithinMargins])
}

// MARK: - Center x/y layouts

public extension Layout {

    public static let centerWithinMargins = LayoutDescriptor<XYLayout>([.centerX, .centerY], otherAttributes: [.centerXWithinMargins, .centerYWithinMargins])
}

// MARK: - Horizontal layouts

public extension Layout {

    public static let horizontalToMargins = LayoutDescriptor<XLayout>([.left, .right], otherAttributes: [.leftMargin, .rightMargin])

    public static let horizontalToLeadingTrailingMargins = LayoutDescriptor<NaturalXLayout>([.leading, .trailing], otherAttributes: [.leadingMargin, .trailingMargin])
}

// MARK: - Vertical layouts

public extension Layout {

    public static let verticalToMargins = LayoutDescriptor<YLayout>([.top, .bottom], otherAttributes: [.topMargin, .bottomMargin])
}

// MARK: - Flush layouts

public extension Layout {

    @available(iOSApplicationExtension 11.0, *)
    public static func flush(with insets: NSDirectionalEdgeInsets) -> LayoutDescriptor<XYLayout> {
        return LayoutDescriptor([.leading, .trailing, .top, .bottom], constants: [insets.leading, insets.trailing, insets.top, insets.bottom], reinterpretConstants: true)
    }

    public static let flushToMargins = LayoutDescriptor<XYLayout>([.left, .right, .top, .bottom], otherAttributes: [.leftMargin, .rightMargin, .topMargin, .bottomMargin], reinterpretConstants: true)

    public static func flushToMargins(with insets: EdgeInsets) -> LayoutDescriptor<XYLayout> {
        return LayoutDescriptor([.left, .right, .top, .bottom], otherAttributes: [.leftMargin, .rightMargin, .topMargin, .bottomMargin], constants: [insets.left, insets.right, insets.top, insets.bottom], reinterpretConstants: true)
    }

    @available(iOSApplicationExtension 11.0, *)
    public static func flushToMargins(with insets: NSDirectionalEdgeInsets) -> LayoutDescriptor<XYLayout> {
        return LayoutDescriptor([.leading, .trailing, .top, .bottom], otherAttributes: [.leadingMargin, .trailingMargin, .topMargin, .bottomMargin], constants: [insets.leading, insets.trailing, insets.top, insets.bottom], reinterpretConstants: true)
    }
}
