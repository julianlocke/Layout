//
//  Utilities.swift
//  Layout
//
//  Created by Cameron Pulsford on 12/29/17.
//  Copyright © 2017 Cameron Pulsford. All rights reserved.
//

#if os(macOS)
    import AppKit
#else
    import UIKit
#endif

func constraintsAreEqual(_ cs1: [NSLayoutConstraint], _ cs2: [NSLayoutConstraint]) -> Bool {
    guard cs1.count == cs2.count else { return false }
    var cs2 = cs2

    outerLoop: for c1 in cs1 {
        for (idx, c2) in cs2.enumerated() where c1.isEqualTo(c2) {
            cs2.remove(at: idx)
            continue outerLoop
        }
    }

    return cs2.isEmpty
}

private extension NSLayoutConstraint {

    func isEqualTo(_ constraint: NSLayoutConstraint) -> Bool {
        return self.firstItem === constraint.firstItem &&
        self.firstAttribute == constraint.firstAttribute &&
        self.secondItem === constraint.secondItem &&
        self.secondAttribute == constraint.secondAttribute &&
        self.relation == constraint.relation &&
        self.multiplier == constraint.multiplier &&
        self.constant == constraint.constant &&
        self.priority == constraint.priority &&
        self.identifier == constraint.identifier
    }
}
