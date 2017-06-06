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

import UIKit

public extension DynamicLayoutManager {

    func add(constraintsFor traits: UITraitCollection, _ block: () -> Void) {
        let allTraits = ConstraintTraintContextStack.shared.parentTraits(with: traits)

        let idiom = allTraits.userInterfaceIdiom
        let rootViewIdiom = rootView.traitCollection.userInterfaceIdiom

        if idiom != .unspecified && rootViewIdiom != .unspecified && idiom != rootViewIdiom {
            // These constraints are for the wrong device so bail to save some cycles.
            // This means nested constraints will not be set up either.
            return
        }

        let ctx = ConstraintTraintContext(allTraits)
        ConstraintTraintContextStack.shared.push(ctx)
        block()
        ConstraintTraintContextStack.shared.pop()

        let constraints = ctx.constraints

        traitBasedConstraints.append((allTraits, constraints))

        if rootView.traitCollection.containsTraits(in: allTraits) {
            constraints.activate()
            currentTraitBasedConstraints += constraints
        }
    }

    func updateTraitBasedConstraints(withTraits newTraits: UITraitCollection? = nil, alongside coordinator: UIViewControllerTransitionCoordinator? = nil) {
        if let coordinator = coordinator {
            coordinator.animate(
                alongsideTransition: { _ in
                    self._updateTraitBasedConstraints(withTraits: newTraits)
            }, completion: nil)
        } else {
            _updateTraitBasedConstraints(withTraits: newTraits)
        }
    }

    private func _updateTraitBasedConstraints(withTraits newTraits: UITraitCollection? = nil) {
        // Ensure this method is not called re-entrantly.
        guard !updatingTraits else {
            return
        }

        updatingTraits = true
        defer { updatingTraits = false }

        let currentTraits = newTraits ?? rootView.traitCollection
        let oldConstraints = currentTraitBasedConstraints
        let newConstraints = traitBasedConstraints.flatMap { tuple -> [NSLayoutConstraint] in
            let (traits, constraints) = tuple

            if currentTraits.containsTraits(in: traits) {
                return constraints
            } else {
                return []
            }
        }

        currentTraitBasedConstraints = newConstraints
        rootView.updateConstraints(deactivate: oldConstraints, activate: newConstraints, immediately: true)
    }
}
