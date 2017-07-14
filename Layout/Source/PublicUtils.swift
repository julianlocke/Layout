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

public extension Array where Element == NSLayoutConstraint {

    /// Activate a sequence of `NSLayoutConstraint`s.
    func activate() {
        let toActivate = filter { !$0.isActive }
        NSLayoutConstraint.activate(toActivate)
    }

    /// Deactivate a sequence of `NSLayoutConstraint`s.
    func deactivate() {
        let toDeactivate = filter { $0.isActive }
        NSLayoutConstraint.deactivate(toDeactivate)
    }
}

public extension View {

    /// Activate and deactivate a set of constraints all at once.
    ///
    /// - Parameters:
    ///   - deactivate: The sequence of constraints to deactivate.
    ///   - activate: The sequence of constraints to activate.
    ///   - immediately: Whether or not the view should be updated immediately.
    ///
    /// - Note:
    /// Passing `true` to the `immediately` parameter on iOS/tvOS has the effect of calling:
    /// ```
    /// setNeedsLayout()
    /// layoutIfNeeded()
    /// ```
    /// on macOS it will call:
    /// ```
    /// needsLayout = true
    /// layoutSubtreeIfNeeded()
    /// ```
    /// It is useful to call from within animation blocks.
    func updateConstraints(deactivate toDeactivate: [NSLayoutConstraint], activate toActivate: [NSLayoutConstraint], immediately: Bool) {
        toDeactivate.deactivate()
        toActivate.activate()

        if immediately {
            #if os(macOS)
                needsLayout = true
                layoutSubtreeIfNeeded()
            #else
                setNeedsLayout()
                layoutIfNeeded()
            #endif
        }
    }
}
