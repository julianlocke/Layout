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

/// An empty protocol used to improve the type-safety of `item` parameters when defining constraints.
/// The only valid implementers of this protocol are `UIView` or `NSView` and `UILayoutGuide` or `NSLayoutGuide`.
public protocol ConstrainableItem {

    var parentView: View? { get }
}

private var currentLayout: Layout?
private var  currentLayoutContext: LayoutContext!

public extension ConstrainableItem {

    @discardableResult
    func makeConstraints(for specs: [ConstraintGroup]) -> [NSLayoutConstraint] {
        if let view = self as? View {
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraints = specs.flatMap { $0.constraints(withItem: self) }

        if let currentLayout = currentLayout {
            currentLayout.addConstraints(constraints, context: currentLayoutContext)
        }

        return constraints
    }

    @discardableResult
    func makeConstraints(_ specs: ConstraintGroup...) -> [NSLayoutConstraint] {
        return makeConstraints(for: specs)
    }

    @discardableResult
    func applyConstraints(for specs: [ConstraintGroup]) -> [NSLayoutConstraint] {
        guard currentLayout == nil else {
            fatalError("applyConstraints may not be called when making a layout.")
        }

        return makeConstraints(for: specs).activate()
    }

    @discardableResult
    func applyConstraints(_ specs: ConstraintGroup...) -> [NSLayoutConstraint] {
        return applyConstraints(for: specs)
    }
}

public extension Layout {

    static func make(rootView: View, _ closure: (LayoutContext) -> Void) -> Layout {
        guard currentLayout == nil else {
            fatalError("Layout.make calls may not be nested")
        }

        let layout = Layout(rootView: rootView)
        currentLayout = layout
        currentLayoutContext = LayoutContext()
        defer {
            currentLayout = nil
            currentLayoutContext = nil
        }
        closure(currentLayoutContext)
        return layout
    }
}

// MARK: -

extension View: ConstrainableItem {

    public var parentView: View? {
        return superview
    }
}

extension LayoutGuide: ConstrainableItem {

    public var parentView: View? {
        return owningView
    }
}
