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

import Layout
import XCTest

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

extension Layout {

    func updateTraits(_ givenTraits: [UITraitCollection]) {
        updateTraits(UITraitCollection(traitsFrom: givenTraits))
    }
}

/// This is borrowed from [here](https://marcosantadev.com/test-swift-fatalerror/#replace_default_fatalError).
extension XCTestCase {

    func expectFatalError(expectedMessage: String, testcase: @escaping () -> Void) {
        let expectation = self.expectation(description: "expectingFatalError")
        var assertionMessage: String? = nil

        FatalErrorUtil.replaceFatalError { message, _, _ in
            assertionMessage = message
            expectation.fulfill()
            self.unreachable()
        }

        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)

        waitForExpectations(timeout: 2) { _ in
            XCTAssertEqual(assertionMessage, expectedMessage)
            FatalErrorUtil.restoreFatalError()
        }
    }

    private func unreachable() -> Never {
        repeat {
            RunLoop.current.run()
        } while (true)
    }
}
