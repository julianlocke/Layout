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

final public class Layout<T> where T: Hashable {

    private var isActive: Bool = false

    internal var fixedConstraints: [NSLayoutConstraint] = []

    internal var groupsToConstraints: [T: [NSLayoutConstraint]] = [:]

    #if os(iOS) || os(tvOS)
    internal var traitsToConstraints: [UITraitCollection: [NSLayoutConstraint]] = [:]
    #endif

    internal init() {

    }

    #if os(iOS) || os(tvOS)
    public func setIsActive(_ isActive: Bool, traits givenTraits: UITraitCollection? = nil) {
        guard isActive != self.isActive else { return }
        self.isActive = isActive
        if isActive {
            fixedConstraints.activate()

            if let givenTraits = givenTraits {
                for (traits, constraints) in traitsToConstraints where givenTraits.containsTraits(in: traits) {
                    constraints.activate()
                }
            }
        } else {
            fixedConstraints.deactivate()

            for constraints in traitsToConstraints.values {
                constraints.deactivate()
            }
        }
    }

    public func updateActiveConstraints(with givenTraits: UITraitCollection) {
        guard isActive else { return }

        var constraintsToActivate: [NSLayoutConstraint] = []

        for (traits, constraints) in traitsToConstraints {
            if givenTraits.containsTraits(in: traits) {
                constraintsToActivate.append(contentsOf: constraints)
            } else {
                constraints.deactivate()
            }
        }

        constraintsToActivate.activate()
    }
    #else
    public func setIsActive(_ isActive: Bool) {
        guard isActive != self.isActive else { return }
        self.isActive = isActive
        if isActive {
            fixedConstraints.activate()
        } else {
            fixedConstraints.deactivate()
        }
    }
    #endif

    internal var __activeConstraints__for_testing_only: [NSLayoutConstraint] {
        let allConstraints: [NSLayoutConstraint]
        #if os(iOS) || os(tvOS)
            allConstraints = fixedConstraints + traitsToConstraints.values.flatMap({ $0 })
        #else
            allConstraints = fixedConstraints
        #endif
        return allConstraints.filter { $0.isActive }
    }
}
