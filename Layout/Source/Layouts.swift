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

public protocol XLayout {}
public protocol NaturalXLayout {}
public protocol YLayout {}
public protocol XYLayout {}
public protocol DimensionLayout {}

public enum Layout {}

public extension Layout {

    public static let left = LayoutDescriptor<XLayout>([.left])

    public static func left(of container: ConstraintContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.left], toItem: container)
    }

    #if os(iOS) || os(tvOS)
    public static let leftMargin = LayoutDescriptor<XLayout>([.leftMargin])

    public static func leftMargin(of container: ConstraintContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.leftMargin], toItem: container)
    }

    public static let leftToMargin = LayoutDescriptor<XLayout>([.left], otherAttributes: [.leftMargin])
    #endif

    public static let leading = LayoutDescriptor<NaturalXLayout>([.leading])

    public static func leading(of container: ConstraintContainer) -> LayoutDescriptor<NaturalXLayout> {
        return LayoutDescriptor([.leading], toItem: container)
    }

    #if os(iOS) || os(tvOS)
    public static let leadingMargin = LayoutDescriptor<NaturalXLayout>([.leadingMargin])

    public static func leadingMargin(of container: ConstraintContainer) -> LayoutDescriptor<NaturalXLayout> {
        return LayoutDescriptor([.leadingMargin], toItem: container)
    }

    public static let leadingToMargin = LayoutDescriptor<NaturalXLayout>([.leading], otherAttributes: [.leadingMargin])
    #endif
}

public extension Layout {

    public static let right = LayoutDescriptor<XLayout>([.right])

    public static func right(of container: ConstraintContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.right], toItem: container)
    }

    #if os(iOS) || os(tvOS)
    public static let rightMargin = LayoutDescriptor<XLayout>([.rightMargin])

    public static func rightMargin(of container: ConstraintContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.rightMargin], toItem: container)
    }

    public static let rightToMargin = LayoutDescriptor<XLayout>([.right], otherAttributes: [.rightMargin])
    #endif

    public static let trailing = LayoutDescriptor<NaturalXLayout>([.trailing])

    public static func trailing(of container: ConstraintContainer) -> LayoutDescriptor<NaturalXLayout> {
        return LayoutDescriptor([.trailing], toItem: container)
    }

    #if os(iOS) || os(tvOS)
    public static let trailingMargin = LayoutDescriptor<NaturalXLayout>([.trailingMargin])

    public static func trailingMargin(of container: ConstraintContainer) -> LayoutDescriptor<NaturalXLayout> {
        return LayoutDescriptor([.trailingMargin], toItem: container)
    }

    public static let trailingToMargin = LayoutDescriptor<NaturalXLayout>([.trailing], otherAttributes: [.trailingMargin])
    #endif
}

public extension Layout {

    public static let top = LayoutDescriptor<YLayout>([.top])

    public static func top(of container: ConstraintContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.top], toItem: container)
    }

    #if os(iOS) || os(tvOS)
    public static let topMargin = LayoutDescriptor<YLayout>([.topMargin])

    public static func topMargin(of container: ConstraintContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.topMargin], toItem: container)
    }

    public static let topToMargin = LayoutDescriptor<YLayout>([.top], otherAttributes: [.topMargin])
    #endif

    public static let firstBaseline = LayoutDescriptor<YLayout>([.firstBaseline])

    public static func firstBaseline(of container: ConstraintContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.firstBaseline], toItem: container)
    }
}

public extension Layout {

    public static let bottom = LayoutDescriptor<YLayout>([.bottom])

    public static func bottom(of container: ConstraintContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.bottom], toItem: container)
    }

    #if os(iOS) || os(tvOS)
    public static let bottomMargin = LayoutDescriptor<YLayout>([.bottomMargin])

    public static func bottomMargin(of container: ConstraintContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.bottomMargin], toItem: container)
    }

    public static let bottomToMargin = LayoutDescriptor<YLayout>([.bottom], otherAttributes: [.bottomMargin])
    #endif

    public static let lastBaseline = LayoutDescriptor<YLayout>([.lastBaseline])

    public static func lastBaseline(of container: ConstraintContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.lastBaseline], toItem: container)
    }
}

public extension Layout {

    public static let centerX = LayoutDescriptor<XLayout>([.centerX])

    public static func centerX(of container: ConstraintContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.centerX], toItem: container)
    }

    #if os(iOS) || os(tvOS)
    public static let centerXWithinMargins = LayoutDescriptor<XLayout>([.centerXWithinMargins])

    public static func centerXWithinMargins(of container: ConstraintContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.centerXWithinMargins], toItem: container)
    }
    #endif
}

public extension Layout {

    public static let centerY = LayoutDescriptor<YLayout>([.centerY])

    public static func centerY(of container: ConstraintContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.centerY], toItem: container)
    }

    #if os(iOS) || os(tvOS)
    public static let centerYWithinMargins = LayoutDescriptor<YLayout>([.centerYWithinMargins])

    public static func centerYWithinMargins(of container: ConstraintContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.centerYWithinMargins], toItem: container)
    }
    #endif
}

public extension Layout {

    #if os(iOS) || os(tvOS)
    public static let centerToXWithinMargins = LayoutDescriptor<XLayout>([.centerX], otherAttributes: [.centerXWithinMargins])

    public static let centerToYWithinMargins = LayoutDescriptor<YLayout>([.centerY], otherAttributes: [.centerYWithinMargins])
    #endif

    public static let center = LayoutDescriptor<XYLayout>([.centerX, .centerY])

    public static func center(of container: ConstraintContainer) -> LayoutDescriptor<XYLayout> {
        return LayoutDescriptor([.centerX, .centerY], toItem: container)
    }

    #if os(iOS) || os(tvOS)
    public static let centerWithinMargins = LayoutDescriptor<XYLayout>([.centerX, .centerY], otherAttributes: [.centerXWithinMargins, .centerYWithinMargins])
    #endif
}

public extension Layout {

    public static let width = LayoutDescriptor<DimensionLayout>([.width])

    public static func width(of container: ConstraintContainer) -> LayoutDescriptor<DimensionLayout> {
        return LayoutDescriptor([.width], toItem: container)
    }

    public static let height = LayoutDescriptor<DimensionLayout>([.height])

    public static func height(of container: ConstraintContainer) -> LayoutDescriptor<DimensionLayout> {
        return LayoutDescriptor([.height], toItem: container)
    }
}

public extension Layout {

    public static let horizontal = LayoutDescriptor<XLayout>([.left, .right])

    #if os(iOS) || os(tvOS)
    public static let horizontalToMargins = LayoutDescriptor<XLayout>([.left, .right], otherAttributes: [.leftMargin, .rightMargin])
    #endif

    public static let horizontalToLeadingTrailing = LayoutDescriptor<NaturalXLayout>([.leading, .trailing])

    #if os(iOS) || os(tvOS)
    public static let horizontalToLeadingTrailingMargins = LayoutDescriptor<NaturalXLayout>([.leading, .trailing], otherAttributes: [.leadingMargin, .trailingMargin])
    #endif
}

public extension Layout {

    public static let vertical = LayoutDescriptor<YLayout>([.top, .bottom])

    #if os(iOS) || os(tvOS)
    public static let verticalToMargins = LayoutDescriptor<YLayout>([.top, .bottom], otherAttributes: [.topMargin, .bottomMargin])
    #endif

    public static let horizontalToBaselines = LayoutDescriptor<YLayout>([.firstBaseline, .lastBaseline])
}

public extension Layout {

    public static let flush = LayoutDescriptor<XYLayout>([.left, .right, .top, .bottom], reinterpretConstants: true)

    public static func flush(with insets: EdgeInsets) -> LayoutDescriptor<XYLayout> {
        return LayoutDescriptor([.left, .right, .top, .bottom], constants: [insets.left, insets.right, insets.top, insets.bottom], reinterpretConstants: true)
    }

    #if os(iOS) || os(tvOS)
    public static let flushToMargins = LayoutDescriptor<XYLayout>([.left, .right, .top, .bottom], otherAttributes: [.leftMargin, .rightMargin, .topMargin, .bottomMargin], reinterpretConstants: true)

    public static func flushToMargins(with insets: EdgeInsets) -> LayoutDescriptor<XYLayout> {
        return LayoutDescriptor([.left, .right, .top, .bottom], otherAttributes: [.leftMargin, .rightMargin, .topMargin, .bottomMargin], constants: [insets.left, insets.right, insets.top, insets.bottom], reinterpretConstants: true)
    }
    #endif
}

public extension Layout {

    public static let size = LayoutDescriptor<DimensionLayout>([.width, .height])

    public static func size(of container: ConstraintContainer) -> LayoutDescriptor<DimensionLayout> {
        return LayoutDescriptor([.width, .height], toItem: container)
    }
}
