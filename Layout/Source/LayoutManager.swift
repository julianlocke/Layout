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

/// A class that manages the storing and activation of sets of simple, fixed constraints.
public class LayoutManager<Key: Hashable> {

    /// The root view of the constraints.
    public let rootView: View

    private var layouts: [Key: [NSLayoutConstraint]] = [:]

    /// Initializes a layout manager with the given root view.
    ///
    /// - Parameter rootView: The root view of the constraints you'd like to manage.
    public init(rootView: View) {
        self.rootView = rootView
    }

    /// Set the given constraints for the given key.
    ///
    /// - Parameters:
    ///   - constraints: The constraints.
    ///   - key: The key.
    /// - Note: Only one set of constraints may be set per key.
    public func set(constraints: [NSLayoutConstraint], for key: Key) {
        guard layouts[key] == nil else {
            fatalError("There are already constraints set for \(key).")
        }

        layouts[key] = constraints
    }

    /// Set the active set of constraints.
    /// - Note: You must already have set the constraints for the active key.
    public var active: Key? {
        didSet {
            var oldConstraints = [NSLayoutConstraint]()

            if let oldKey = oldValue {
                if oldKey == active {
                    return
                } else {
                    oldConstraints = layouts[oldKey] ?? []
                }
            }

            if let newKey = active {
                if let newConstraints = layouts[newKey] {
                    rootView.updateConstraints(deactivate: oldConstraints, activate: newConstraints)
                } else {
                    fatalError("No constraints for key '\(newKey)'")
                }
            }
        }
    }
}
