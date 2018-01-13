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

public enum XPosition {
    case leading
    case trailing
    case centerX
    #if os(iOS) || os(tvOS)
    case leadingMargin
    case trailingMargin
    case centerXWithinMargins
    #endif

    internal var layoutAttribute: LayoutAttribute {
        #if os(iOS) || os(tvOS)
            switch self {
            case .leading:
                return .leading
            case .trailing:
                return .trailing
            case .centerX:
                return .centerX
            case .leadingMargin:
                return .leadingMargin
            case .trailingMargin:
                return .trailingMargin
            case .centerXWithinMargins:
                return .centerXWithinMargins
            }
        #else
            switch self {
            case .leading:
                return .leading
            case .trailing:
                return .trailing
            case .centerX:
                return .centerX
            }
        #endif
    }
}

public enum YPosition {
    case top
    case bottom
    case centerY
    case firstBaseline
    case lastBaseline
    #if os(iOS) || os(tvOS)
    case topMargin
    case bottomMargin
    case centerYWithinMargins
    #endif

    internal var layoutAttribute: LayoutAttribute {
        #if os(iOS) || os(tvOS)
            switch self {
            case .top:
                return .top
            case .bottom:
                return .bottom
            case .centerY:
                return .centerY
            case .firstBaseline:
                return .firstBaseline
            case .lastBaseline:
                return .lastBaseline
            case .topMargin:
                return .topMargin
            case .bottomMargin:
                return .bottomMargin
            case .centerYWithinMargins:
                return .centerYWithinMargins
            }
        #else
            switch self {
            case .top:
                return .top
            case .bottom:
                return .bottom
            case .centerY:
                return .centerY
            case .firstBaseline:
                return .firstBaseline
            case .lastBaseline:
                return .lastBaseline
            }
        #endif
    }
}

public enum Dimension {
    case width
    case height

    internal var layoutAttribute: LayoutAttribute {
        switch self {
        case .width:
            return .width
        case .height:
            return .height
        }
    }
}
