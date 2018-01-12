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

internal protocol ConstraintContainer: class {

    func addConstraints(_ constraints: [NSLayoutConstraint])
}

final public class LayoutContext<T>: ConstraintContainer where T: Hashable {

    private unowned var layout: Layout<T>

    private var currentGroup: T?

    init(layout: Layout<T>) {
        self.layout = layout
    }

    public func group(_ group: T, closure: () -> Void) {
        #if os(iOS) || os(tvOS)
        guard traits == nil else {
            fatalError("grouped constraints may not be nested within trait-based constraints.")
        }
        #endif

        guard currentGroup == nil else {
            fatalError("\(#function) calls may not be nested.")
        }

        currentGroup = group
        defer { currentGroup = nil }
        closure()
    }

    #if os(iOS) || os(tvOS)
    private var traitHierarchy: [UITraitCollection] = []

    fileprivate var traits: UITraitCollection? {
        return traitHierarchy.isEmpty ? nil : UITraitCollection(traitsFrom: traitHierarchy)
    }

    public func when(_ trait: UITraitCollection, _ traits: UITraitCollection..., closure: () -> Void) {
        guard currentGroup == nil else {
            fatalError("Trait-based constraints may not be nested within grouped constraints.")
        }
        traitHierarchy.append(UITraitCollection(traitsFrom: [trait] + traits))
        defer { traitHierarchy.removeLast() }
        closure()
    }
    #endif

    internal func addConstraints(_ constraints: [NSLayoutConstraint]) {
        #if os(iOS) || os(tvOS)
            if let group = currentGroup {
                layout.groupsToConstraints[group, default: []].append(contentsOf: constraints)
            } else if let traits = traits {
                layout.traitsToConstraints[traits, default: []].append(contentsOf: constraints)
            } else {
                layout.fixedConstraints += constraints
            }
        #else
            if let group = currentGroup {
                layout.groupsToConstraints[group, default: []].append(contentsOf: constraints)
            } else {
                layout.fixedConstraints += constraints
            }
        #endif
    }
}
