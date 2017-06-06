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

// MARK: - Left/leading layouts

public extension Layout {

    public static let left = LayoutDescriptor<XLayout>([.left])

    public static func left(of container: ConstraintContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.left], toItem: container)
    }

    public static let leading = LayoutDescriptor<NaturalXLayout>([.leading])

    public static func leading(of container: ConstraintContainer) -> LayoutDescriptor<NaturalXLayout> {
        return LayoutDescriptor([.leading], toItem: container)
    }
}

// MARK: - Right/trailing layouts

public extension Layout {

    public static let right = LayoutDescriptor<XLayout>([.right])

    public static func right(of container: ConstraintContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.right], toItem: container)
    }

    public static let trailing = LayoutDescriptor<NaturalXLayout>([.trailing])

    public static func trailing(of container: ConstraintContainer) -> LayoutDescriptor<NaturalXLayout> {
        return LayoutDescriptor([.trailing], toItem: container)
    }
}

// MARK: - Top/baseline layouts

public extension Layout {

    public static let top = LayoutDescriptor<YLayout>([.top])

    public static func top(of container: ConstraintContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.top], toItem: container)
    }

    public static let firstBaseline = LayoutDescriptor<YLayout>([.firstBaseline])

    public static func firstBaseline(of container: ConstraintContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.firstBaseline], toItem: container)
    }
}

// MARK: - Bottom/baseline layouts

public extension Layout {

    public static let bottom = LayoutDescriptor<YLayout>([.bottom])

    public static func bottom(of container: ConstraintContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.bottom], toItem: container)
    }

    public static let lastBaseline = LayoutDescriptor<YLayout>([.lastBaseline])

    public static func lastBaseline(of container: ConstraintContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.lastBaseline], toItem: container)
    }
}

// MARK: - Center x layouts

public extension Layout {

    public static let centerX = LayoutDescriptor<XLayout>([.centerX])

    public static func centerX(of container: ConstraintContainer) -> LayoutDescriptor<XLayout> {
        return LayoutDescriptor([.centerX], toItem: container)
    }
}

// MARK: - Center y layouts

public extension Layout {

    public static let centerY = LayoutDescriptor<YLayout>([.centerY])

    public static func centerY(of container: ConstraintContainer) -> LayoutDescriptor<YLayout> {
        return LayoutDescriptor([.centerY], toItem: container)
    }
}

// MARK: - Center x/y layouts

public extension Layout {

    public static let center = LayoutDescriptor<XYLayout>([.centerX, .centerY])

    public static func center(of container: ConstraintContainer) -> LayoutDescriptor<XYLayout> {
        return LayoutDescriptor([.centerX, .centerY], toItem: container)
    }
}

// MARK: - Width/height/size layouts

public extension Layout {

    public static let width = LayoutDescriptor<DimensionLayout>([.width])

    public static func width(of container: ConstraintContainer) -> LayoutDescriptor<DimensionLayout> {
        return LayoutDescriptor([.width], toItem: container)
    }

    public static let height = LayoutDescriptor<DimensionLayout>([.height])

    public static func height(of container: ConstraintContainer) -> LayoutDescriptor<DimensionLayout> {
        return LayoutDescriptor([.height], toItem: container)
    }

    public static let size = LayoutDescriptor<DimensionLayout>([.width, .height])

    public static func size(of container: ConstraintContainer) -> LayoutDescriptor<DimensionLayout> {
        return LayoutDescriptor([.width, .height], toItem: container)
    }
}

// MARK: - Horizontal layouts

public extension Layout {

    public static let horizontal = LayoutDescriptor<XLayout>([.left, .right])

    public static let horizontalToLeadingTrailing = LayoutDescriptor<NaturalXLayout>([.leading, .trailing])
}

// MARK: - Vertical layouts

public extension Layout {

    public static let vertical = LayoutDescriptor<YLayout>([.top, .bottom])

    public static let horizontalToBaselines = LayoutDescriptor<YLayout>([.firstBaseline, .lastBaseline])
}

// MARK: - Flush layouts

public extension Layout {

    public static let flush = LayoutDescriptor<XYLayout>([.left, .right, .top, .bottom], reinterpretConstants: true)

    public static func flush(with insets: EdgeInsets) -> LayoutDescriptor<XYLayout> {
        return LayoutDescriptor([.left, .right, .top, .bottom], constants: [insets.left, insets.right, insets.top, insets.bottom], reinterpretConstants: true)
    }
}
