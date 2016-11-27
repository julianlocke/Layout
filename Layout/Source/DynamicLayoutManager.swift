/*
 The MIT License (MIT)

 Copyright (c) 2016 Cameron Pulsford

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

public protocol DynamicLayoutConstraintContext {
    func add(_ constraints: [NSLayoutConstraint])
}

public class DynamicLayoutManager {

    public let rootView: UIView

    public init(rootView rv: UIView) {
        rootView = rv
    }

    fileprivate var dynamicConstraintBlocks: [() -> ([NSLayoutConstraint])] = []
    fileprivate var currentDynamicConstraints: [NSLayoutConstraint] = []

    fileprivate var updatingTraits = false
    fileprivate var traitBasedConstraints: [(UITraitCollection, [NSLayoutConstraint])] = []
    fileprivate var currentTraitBasedConstraints: [NSLayoutConstraint] = []

    fileprivate var traitBasedBlocks: [(UITraitCollection, CGSize) -> ()] = []
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

public extension DynamicLayoutManager {
    func add(constraintsMatching traits: UITraitCollection, _ block: (DynamicLayoutConstraintContext) -> ()) {
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

    func add(_ traitBasedBlock: @escaping (UITraitCollection, CGSize) -> ()) {
        traitBasedBlocks.append(traitBasedBlock)
    }

    func updateTraitBasedConstraints(withTraits newTraits: UITraitCollection? = nil, size: CGSize? = nil) {
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

    func updateTraitBasedConstraints(withTraits newTraits: UITraitCollection, coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(
            alongsideTransition: { _ in
                self.updateTraitBasedConstraints(withTraits: newTraits)
        }, completion: nil)
    }
}

fileprivate class ConstraintContext: DynamicLayoutConstraintContext {
    fileprivate var constraints: [NSLayoutConstraint] = []

    fileprivate func add(_ constraints: [NSLayoutConstraint]) {
        self.constraints += constraints
    }
}

private func interfaceOrientation() -> UIInterfaceOrientation {
    return UIApplication.shared.statusBarOrientation
}

private extension UIInterfaceOrientation {
    var portrait: Bool {
        switch self {
        case .portrait, .portraitUpsideDown:
            return true
        default:
            return false
        }
    }

    var landscape: Bool {
        switch self {
        case .landscapeLeft, .landscapeRight:
            return true
        default:
            return false
        }
    }
}
