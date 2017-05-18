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

/// A protocol representing a container that can have constraints applied to it.
public protocol ConstraintContainer {

    var parentView: View? { get }
}

extension View: ConstraintContainer {

    /// Returns the receiver's `superview`.
    public var parentView: View? {
        return superview
    }
}

extension LayoutGuide: ConstraintContainer {

    /// Returns the receiver's `owningView`.
    public var parentView: View? {
        return owningView
    }
}

public extension ConstraintContainer {

    internal func createLayout(constraints: [LayoutConstraintGenerator], activate: Bool) -> [NSLayoutConstraint] {
        if let view = self as? View {
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraints = constraints.flatMap({ $0.constraints(for: self) })

        #if os(iOS) || os(tvOS)
            if let ctx = ConstraintTraintContextStack.shared.current {
                ctx.constraints += constraints

                if activate {
                    fatalError("You must use createLayout, rather than applyLayout, in this context.")
                }
            }
        #endif

        if activate {
            constraints.activate()
        }

        return constraints
    }

    /// Create layout constraints for the given generators. The constraints will not be activated.
    ///
    /// - Parameter constraints: The constraint generators.
    /// - Returns: The layout constraints from the given generators.
    @discardableResult
    func createLayout(_ constraints: LayoutConstraintGenerator...) -> [NSLayoutConstraint] {
        return createLayout(constraints: constraints, activate: false)
    }

    /// Create and activate layout constraints for the given generators.
    ///
    /// - Parameter constraints: The constraint generators.
    /// - Returns: The layout constraints from the given generators.
    @discardableResult
    func applyLayout(_ constraints: LayoutConstraintGenerator...) -> [NSLayoutConstraint] {
        return createLayout(constraints: constraints, activate: true)
    }
}
