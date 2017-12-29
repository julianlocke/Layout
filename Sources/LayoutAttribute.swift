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

#if os(macOS)
    public enum XPosition {
        case leading
        case trailing
        case centerX

        internal var layoutAttribute: LayoutAttribute {
            switch self {
            case .leading:
                return .leading
            case .trailing:
                return .trailing
            case .centerX:
                return .centerX
            }
        }
    }

    public enum YPosition {
        case top
        case bottom
        case centerY
        case firstBaseline
        case lastBaseline

        internal var layoutAttribute: LayoutAttribute {
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
        }
    }
#else
    public enum XPosition {
        case leading
        case leadingMargin
        case trailing
        case trailingMargin
        case centerX
        case centerXWithinMargins

        internal var layoutAttribute: LayoutAttribute {
            switch self {
            case .leading:
                return .leading
            case .leadingMargin:
                return .leadingMargin
            case .trailing:
                return .trailing
            case .trailingMargin:
                return .trailingMargin
            case .centerX:
                return .centerX
            case .centerXWithinMargins:
                return .centerXWithinMargins
            }
        }
    }

    public enum YPosition {
        case top
        case topMargin
        case bottom
        case bottomMargin
        case centerY
        case centerYWithinMargins
        case firstBaseline
        case lastBaseline

        internal var layoutAttribute: LayoutAttribute {
            switch self {
            case .top:
                return .top
            case .topMargin:
                return .topMargin
            case .bottom:
                return .bottom
            case .bottomMargin:
                return .bottomMargin
            case .centerY:
                return .centerY
            case .centerYWithinMargins:
                return .centerYWithinMargins
            case .firstBaseline:
                return .firstBaseline
            case .lastBaseline:
                return .lastBaseline
            }
        }
    }
#endif

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
