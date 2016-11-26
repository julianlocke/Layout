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

public protocol XLayout {}
public protocol YLayout {}
public protocol XYLayout {}
public protocol DimensionLayout {}

public enum Layout {}

public extension Layout {
    public static let left = LayoutDescriptor<XLayout>([.left])

    public static func left(of container: LayoutContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.left], toItem: container)
    }

    public static let leftMargin = LayoutDescriptor<XLayout>([.leftMargin])

    public static func leftMargin(of container: LayoutContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.leftMargin], toItem: container)
    }

    public static let leftToMargin = LayoutDescriptor<XLayout>([.left], otherAttributes: [.leftMargin])

    public static let leading = LayoutDescriptor<XLayout>([.leading])

    public static func leading(of container: LayoutContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.leading], toItem: container)
    }

    public static let leadingMargin = LayoutDescriptor<XLayout>([.leadingMargin])

    public static func leadingMargin(of container: LayoutContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.leadingMargin], toItem: container)
    }

    public static let leadingToMargin = LayoutDescriptor<XLayout>([.leading], otherAttributes: [.leadingMargin])
}

public extension Layout {
    public static let right = LayoutDescriptor<XLayout>([.right])

    public static func right(of container: LayoutContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.right], toItem: container)
    }

    public static let rightMargin = LayoutDescriptor<XLayout>([.rightMargin])

    public static func rightMargin(of container: LayoutContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.rightMargin], toItem: container)
    }

    public static let rightToMargin = LayoutDescriptor<XLayout>([.right], otherAttributes: [.rightMargin])

    public static let trailing = LayoutDescriptor<XLayout>([.trailing])

    public static func trailing(of container: LayoutContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.trailing], toItem: container)
    }

    public static let trailingMargin = LayoutDescriptor<XLayout>([.trailingMargin])

    public static func trailingMargin(of container: LayoutContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.trailingMargin], toItem: container)
    }

    public static let trailingToMargin = LayoutDescriptor<XLayout>([.trailing], otherAttributes: [.trailingMargin])
}

public extension Layout {
    public static let top = LayoutDescriptor<YLayout>([.top])

    public static func top(of container: LayoutContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.top], toItem: container)
    }

    public static let topMargin = LayoutDescriptor<YLayout>([.topMargin])

    public static func topMargin(of container: LayoutContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.topMargin], toItem: container)
    }

    public static let topToMargin = LayoutDescriptor<YLayout>([.top], otherAttributes: [.topMargin])

    public static var firstBaseline = LayoutDescriptor<YLayout>([.firstBaseline])

    public static func firstBaseline(of container: LayoutContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.firstBaseline], toItem: container)
    }
}

public extension Layout {
    public static let bottom = LayoutDescriptor<YLayout>([.bottom])

    public static func bottom(of container: LayoutContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.bottom], toItem: container)
    }

    public static let bottomMargin = LayoutDescriptor<YLayout>([.bottomMargin])

    public static func bottomMargin(of container: LayoutContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.bottomMargin], toItem: container)
    }

    public static let bottomToMargin = LayoutDescriptor<YLayout>([.bottom], otherAttributes: [.bottomMargin])

    public static var lastBaseline = LayoutDescriptor<YLayout>([.lastBaseline])

    public static func lastBaseline(of container: LayoutContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.lastBaseline], toItem: container)
    }
}

public extension Layout {
    public static let centerX = LayoutDescriptor<XLayout>([.centerX])

    public static func centerX(of container: LayoutContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.centerX], toItem: container)
    }

    public static let centerXWithinMargins = LayoutDescriptor<XLayout>([.centerXWithinMargins])

    public static func centerXWithinMargins(of container: LayoutContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.centerXWithinMargins], toItem: container)
    }
}

public extension Layout {
    public static let centerY = LayoutDescriptor<YLayout>([.centerY])

    public static func centerY(of container: LayoutContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.centerY], toItem: container)
    }

    public static let centerYWithinMargins = LayoutDescriptor<XLayout>([.centerYWithinMargins])

    public static func centerYWithinMargins(of container: LayoutContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.centerYWithinMargins], toItem: container)
    }
}

public extension Layout {
    public static let centerToXWithinMargins = LayoutDescriptor<XLayout>([.centerX], otherAttributes: [.centerXWithinMargins])

    public static let centerToYWithinMargins = LayoutDescriptor<YLayout>([.centerY], otherAttributes: [.centerYWithinMargins])

    public static let center = LayoutDescriptor<XYLayout>([.centerX, .centerY])

    public static func center(of: LayoutContainer) -> LayoutDescriptor<XYLayout> {
        return LayoutDescriptor([.centerX, .centerY])
    }

    public static let centerWithinMargins = LayoutDescriptor<XYLayout>([.centerX, .centerY], otherAttributes: [.centerXWithinMargins, .centerYWithinMargins])
}

public extension Layout {
    public static let width = LayoutDescriptor<DimensionLayout>([.width])

    public static func width(of container: LayoutContainer) -> LayoutDescriptor<DimensionLayout> {
        return LayoutDescriptor([.width], toItem: container)
    }

    public static let height = LayoutDescriptor<DimensionLayout>([.height])

    public static func height(of container: LayoutContainer) -> LayoutDescriptor<DimensionLayout> {
        return LayoutDescriptor([.height], toItem: container)
    }
}

public extension Layout {
    public static let horizontal = LayoutDescriptor<XLayout>([.left, .right])

    public static let horizontalToMargins = LayoutDescriptor<XLayout>([.left, .right], otherAttributes: [.leftMargin, .rightMargin])

    public static let horizontalToLeadingTrailing = LayoutDescriptor<XLayout>([.leading, .trailing])

    public static let horizontalToLeadingTrailingMargins = LayoutDescriptor<XLayout>([.leading, .trailing], otherAttributes: [.leadingMargin, .trailingMargin])
}

public extension Layout {
    public static let vertical = LayoutDescriptor<YLayout>([.top, .bottom])

    public static let verticalToMargins = LayoutDescriptor<YLayout>([.top, .bottom], otherAttributes: [.topMargin, .bottomMargin])

    public static let horizontalToBaselines = LayoutDescriptor<YLayout>([.firstBaseline, .lastBaseline])
}

public extension Layout {
    public static let flush = LayoutDescriptor<XYLayout>([.left, .right, .top, .bottom], reinterpretConstants: true)

    public static func flush(with insets: UIEdgeInsets) -> LayoutDescriptor<XYLayout> {
        return LayoutDescriptor([.left, .right, .top, .bottom], constants: [insets.left, -insets.right, insets.top, -insets.bottom])
    }

    public static let flushToMargins = LayoutDescriptor<XYLayout>([.left, .right, .top, .bottom], otherAttributes: [.leftMargin, .rightMargin, .topMargin, .bottomMargin], reinterpretConstants: true)

    public static func flushToMargins(with insets: UIEdgeInsets) -> LayoutDescriptor<XYLayout> {
        return LayoutDescriptor([.left, .right, .top, .bottom], otherAttributes: [.leftMargin, .rightMargin, .topMargin, .bottomMargin], constants: [insets.left, -insets.right, insets.top, -insets.bottom])
    }
}

public extension Layout {
    public static let size = LayoutDescriptor<DimensionLayout>([.width, .height])
}
