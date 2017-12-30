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

final public class LayoutContext {

    #if os(iOS) || os(tvOS)
    private var traitHierarchy: [UITraitCollection] = []

    fileprivate var traits: UITraitCollection? {
        return traitHierarchy.isEmpty ? nil : UITraitCollection(traitsFrom: traitHierarchy)
    }

    public func when(_ traits: UITraitCollection..., closure: () -> Void) {
        traitHierarchy.append(UITraitCollection(traitsFrom: traits))
        defer { traitHierarchy.removeLast() }
        closure()
    }
    #endif
}

final public class Layout {

    public let rootView: View

    #if os(iOS) || os(tvOS)
    public private(set) var isActive: Bool = false
    #else
    public var isActive: Bool = false {
        didSet {
            guard isActive != oldValue else { return }
            if isActive {
                constraints.activate()
            } else {
                constraints.deactivate()
            }
        }
    }
    #endif

    private var constraints: [NSLayoutConstraint] = []

    #if os(iOS) || os(tvOS)
    private var traitsToConstraints: [UITraitCollection: [NSLayoutConstraint]] = [:]
    #endif

    public init(rootView: View) {
        self.rootView = rootView
    }

    #if os(iOS) || os(tvOS)
    public func setIsActive(_ isActive: Bool, traits givenTraits: UITraitCollection...) {
        guard isActive != self.isActive else { return }
        self.isActive = isActive
        if isActive {
            constraints.activate()

            let constraintsToCheck = givenTraits.isEmpty ? rootView.traitCollection : UITraitCollection(traitsFrom: givenTraits)
            for (traits, constraints) in traitsToConstraints where constraintsToCheck.containsTraits(in: traits) {
                constraints.activate()
            }
        } else {
            constraints.deactivate()

            for constraints in traitsToConstraints.values {
                constraints.deactivate()
            }
        }
    }

    public func updateActiveConstraints(with givenTraits: UITraitCollection...) {
        guard isActive else { return }
        let constraintsToCheck = givenTraits.isEmpty ? rootView.traitCollection : UITraitCollection(traitsFrom: givenTraits)

        for (traits, constraints) in traitsToConstraints {
            if constraintsToCheck.containsTraits(in: traits) {
                constraints.activate()
            } else {
                constraints.deactivate()
            }
        }
    }
    #endif

    internal func addConstraints(_ newConstraints: [NSLayoutConstraint], context: LayoutContext) {
        #if os(iOS) || os(tvOS)
        if let traits = context.traits {
            traitsToConstraints[traits, default: []].append(contentsOf: newConstraints)
            if rootView.traitCollection.containsTraits(in: context.traits) {
                if isActive {
                    newConstraints.activate()
                }
            }
        } else {
            constraints += newConstraints
            if isActive {
                newConstraints.activate()
            }
        }
        #else
        constraints += newConstraints
        if isActive {
            newConstraints.activate()
        }
        #endif
    }
}
