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

public extension Sequence where Iterator.Element == NSLayoutConstraint {
    func activate() {
        NSLayoutConstraint.activate(Array(self))
    }

    func deactivate() {
        NSLayoutConstraint.deactivate(Array(self))
    }
}

public extension UIView {
    func updateConstraints(deactivate: [NSLayoutConstraint], activate: [NSLayoutConstraint], immediately: Bool = true) {
        var oldConstraints = Set(deactivate)
        var newConstraints = Set(activate)

        // Remove any constraints that are already active.
        // There's no need to deactivate/reactivate.
        for constraint in activate {
            if constraint.isActive && oldConstraints.contains(constraint) {
                oldConstraints.remove(constraint)
                newConstraints.remove(constraint)
            }
        }

        oldConstraints.deactivate()
        newConstraints.activate()

        if immediately {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
}

public extension Sequence where Iterator.Element == UITraitCollection {
    var combined: UITraitCollection {
        return UITraitCollection(traitsFrom: Array(self))
    }
}

public extension UITraitCollection {
    static func idiom(_ idiom: UIUserInterfaceIdiom) -> UITraitCollection {
        return UITraitCollection(userInterfaceIdiom: idiom)
    }

    static func layoutDirection(_ layoutDirection: UITraitEnvironmentLayoutDirection) -> UITraitCollection {
        return UITraitCollection(layoutDirection: layoutDirection)
    }

    static func displayScale(_ displayScale: CGFloat) -> UITraitCollection {
        return UITraitCollection(displayScale: displayScale)
    }

    static func horizontally(_ sizeClass: UIUserInterfaceSizeClass) -> UITraitCollection {
        return UITraitCollection(horizontalSizeClass: sizeClass)
    }

    static func vertically(_ sizeClass: UIUserInterfaceSizeClass) -> UITraitCollection {
        return UITraitCollection(verticalSizeClass: sizeClass)
    }

    static func forceTouchCapability(_ capability: UIForceTouchCapability) -> UITraitCollection {
        return UITraitCollection(forceTouchCapability: capability)
    }

    static func preferredContentSizeCategory(_ category: UIContentSizeCategory) -> UITraitCollection {
        return UITraitCollection(preferredContentSizeCategory: category)
    }

    static func displayGamut(_ value: UIDisplayGamut) -> UITraitCollection {
        return UITraitCollection(displayGamut: value)
    }
}

public func && (lhs: UITraitCollection, rhs: UITraitCollection) -> UITraitCollection {
    return [lhs, rhs].combined
}
