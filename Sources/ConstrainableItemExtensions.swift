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

private var currentLayout: Any?
private var currentLayoutContext: ConstraintContainer?

public extension ConstrainableItem {

    @discardableResult
    func makeConstraints(for specs: [ConstraintSpecGroup]) -> [NSLayoutConstraint] {
        if let view = self as? View {
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraints = specs.flatMap { $0.constraints(withItem: self) }
        currentLayoutContext?.addConstraints(constraints)
        return constraints
    }

    @discardableResult
    func makeConstraints(_ specs: ConstraintSpecGroup...) -> [NSLayoutConstraint] {
        return makeConstraints(for: specs)
    }

    @discardableResult
    func applyConstraints(for specs: [ConstraintSpecGroup]) -> [NSLayoutConstraint] {
        let constraints = makeConstraints(for: specs)

        if currentLayoutContext == nil {
            constraints.activate()
        }

        return constraints
    }

    @discardableResult
    func applyConstraints(_ specs: ConstraintSpecGroup...) -> [NSLayoutConstraint] {
        return applyConstraints(for: specs)
    }
}

public extension Layout {

    convenience init(_ closure: (LayoutContext<T>) -> Void) {
        guard currentLayout == nil else {
            currentLayout = nil // `nil` this out for unit test purposes 😬.
            fatalError("Layout() calls may not be nested.")
        }

        self.init()
        currentLayout = self
        let ctx = LayoutContext(layout: self)
        currentLayoutContext = ctx
        defer {
            currentLayout = nil
            currentLayoutContext = nil
        }
        closure(ctx)

        // Activate the "always" constraints.
        fixedConstraints.activate()
    }
}
