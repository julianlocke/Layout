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

public protocol DynamicLayoutConstraintContext {
    func add(_ constraints: [NSLayoutConstraint])
}

public class DynamicLayoutManager {

    public let rootView: View

    public init(rootView rv: View) {
        rootView = rv
    }

    fileprivate var dynamicConstraintBlocks: [() -> ([NSLayoutConstraint])] = []
    fileprivate var currentDynamicConstraints: [NSLayoutConstraint] = []

    #if os(iOS) || os(tvOS)
    fileprivate var updatingTraits = false
    fileprivate var traitBasedConstraints: [(UITraitCollection, [NSLayoutConstraint])] = []
    fileprivate var currentTraitBasedConstraints: [NSLayoutConstraint] = []

    fileprivate var traitBasedBlocks: [(UITraitCollection, CGSize) -> Void] = []
    #endif
}

public extension DynamicLayoutManager {
    func add(dynamicConstraints: @escaping () -> ([NSLayoutConstraint])) {
        dynamicConstraintBlocks.append(dynamicConstraints)
    }

    func updateDynamicConstraints() {
        let oldConstraints = currentDynamicConstraints
        let newConstraints = dynamicConstraintBlocks.flatMap({ $0() })

        currentDynamicConstraints = newConstraints
        rootView.updateConstraints(deactivate: oldConstraints, activate: newConstraints)
    }
}

#if os(iOS) || os(tvOS)
public extension DynamicLayoutManager {
    func add(constraintsFor traits: UITraitCollection, _ block: (DynamicLayoutConstraintContext) -> Void) {
        let ctx = ConstraintContext()
        block(ctx)

        let constraints = ctx.constraints

        traitBasedConstraints.append((traits, constraints))

        if rootView.traitCollection.containsTraits(in: traits) {
            constraints.activate()
            currentTraitBasedConstraints += constraints
        } else {
            constraints.deactivate()
        }
    }

    func add(constraintsFor traits: UITraitCollection, _ constraints: [NSLayoutConstraint]) {
        add(constraintsFor: traits, { ctx in
            ctx.add(constraints)
        })
    }

    func add(_ traitBasedBlock: @escaping (UITraitCollection, CGSize) -> Void) {
        traitBasedBlocks.append(traitBasedBlock)
    }

    func updateTraitBasedConstraints(withTraits newTraits: UITraitCollection? = nil, size: CGSize? = nil, coordinator: UIViewControllerTransitionCoordinator? = nil) {
        if let coordinator = coordinator {
            coordinator.animate(
                alongsideTransition: { _ in
                    self._updateTraitBasedConstraints(withTraits: newTraits, size: size)
            }, completion: nil)
        } else {
            _updateTraitBasedConstraints(withTraits: newTraits, size: size)
        }

    }

    private func _updateTraitBasedConstraints(withTraits newTraits: UITraitCollection? = nil, size: CGSize? = nil) {
        // Updating constraints can cause traits to change,
        // so make sure this function is not executed again
        // while we are still running.
        guard !updatingTraits else {
            return
        }

        updatingTraits = true

        let currentTraits = newTraits ?? rootView.traitCollection
        let oldConstraints = currentTraitBasedConstraints
        let newConstraints = traitBasedConstraints.flatMap { t -> [NSLayoutConstraint] in
            let (traits, constraints) = t

            if currentTraits.containsTraits(in: traits) {
                return constraints
            } else {
                return []
            }
        }

        for traitBasedBlock in traitBasedBlocks {
            traitBasedBlock(currentTraits, size ?? rootView.bounds.size)
        }

        currentTraitBasedConstraints = newConstraints
        rootView.updateConstraints(deactivate: oldConstraints, activate: newConstraints)
        updatingTraits = false
    }
}
#endif

fileprivate class ConstraintContext: DynamicLayoutConstraintContext {
    fileprivate var constraints: [NSLayoutConstraint] = []

    fileprivate func add(_ constraints: [NSLayoutConstraint]) {
        self.constraints += constraints
    }
}
