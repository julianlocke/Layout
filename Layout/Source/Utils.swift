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

// swiftlint:disable:next large_tuple
func zip3<V1, V2, V3>(_ seq1: [V1], _ seq2: [V2], _ seq3: [V3]) -> [(V1, V2, V3)] {
    guard seq1.count == seq2.count && seq2.count == seq3.count else {
        fatalError("All arrays must be the same length.")
    }

    return seq1.indices.map {
        (seq1[$0], seq2[$0], seq3[$0])
    }
}

extension LayoutAttribute {
    var requiresReinterpretation: Bool {
        #if os(macOS)
            switch self {
            case .right, .trailing, .bottom, .lastBaseline:
                return true
            default:
                return false
            }
        #else
            switch self {
            case .right, .rightMargin, .trailing, .trailingMargin, .bottom, .bottomMargin, .lastBaseline:
                return true
            default:
                return false
            }
        #endif
    }
}
