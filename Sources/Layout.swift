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

final public class Layout<T> where T: Hashable {

    internal var fixedConstraints: [NSLayoutConstraint] = []

    internal var groupsToConstraints: [T: [NSLayoutConstraint]] = [:]

    internal init() {

    }

    public func updateGroupedConstraints(activate: [T] = [], deactivate: [T] = []) {
        deactivate.forEach {
            groupsToConstraints[$0]?.deactivate()
        }

        activate.forEach {
            groupsToConstraints[$0]?.activate()
        }
    }

    public func deactivateAllGroupedConstraints() {
        groupsToConstraints.values.forEach { $0.deactivate }
    }

    #if os(iOS) || os(tvOS)
    private var currentTraits = UITraitCollection()

    private var activeTraitConstraints: [NSLayoutConstraint] = []

    internal var traitsToConstraints: [UITraitCollection: [NSLayoutConstraint]] = [:]

    public func updateTraits(_ givenTraits: UITraitCollection) {
        guard currentTraits != givenTraits else { return }
        currentTraits = givenTraits

        activeTraitConstraints.deactivate()
        activeTraitConstraints = traitsToConstraints
            .filter { givenTraits.containsTraits(in: $0.key) }
            .map { $0.value }
            .flatMap { $0 }
            .activate()
    }
    #endif

    internal var __activeConstraints__for_testing_only: [NSLayoutConstraint] {
        var allConstraints = fixedConstraints + groupsToConstraints.values.flatMap { $0 }
        #if os(iOS) || os(tvOS)
            allConstraints += traitsToConstraints.values.flatMap({ $0 })
        #endif
        return allConstraints.filter { $0.isActive }
    }
}
