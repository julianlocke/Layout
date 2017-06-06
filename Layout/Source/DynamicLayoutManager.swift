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

public class DynamicLayoutManager {

    public let rootView: View

    public init(rootView: View) {
        self.rootView = rootView
    }

    private var dynamicConstraintBlocks: [() -> [NSLayoutConstraint]] = []
    private var currentDynamicConstraints: [NSLayoutConstraint] = []

    #if os(iOS) || os(tvOS)
    internal var updatingTraits = false
    internal var traitBasedConstraints: [(UITraitCollection, [NSLayoutConstraint])] = []
    internal var currentTraitBasedConstraints: [NSLayoutConstraint] = []
    #endif
}

public extension DynamicLayoutManager {

    func add(dynamicConstraints: @escaping () -> [NSLayoutConstraint]) {
        dynamicConstraintBlocks.append(dynamicConstraints)
    }

    func updateDynamicConstraints() {
        let oldConstraints = currentDynamicConstraints
        let newConstraints = dynamicConstraintBlocks.flatMap({ $0() })

        currentDynamicConstraints = newConstraints
        rootView.updateConstraints(deactivate: oldConstraints, activate: newConstraints, immediately: true)
    }
}
