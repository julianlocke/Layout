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

@testable import Layout

extension View {

    @discardableResult
    func immediatelyApplyLayout(_ constraints: LayoutConstraintGenerator...) -> [NSLayoutConstraint] {
        let constraints = createLayout(constraints: constraints, activate: false)
        superview?.updateConstraints(deactivate: [], activate: constraints, immediately: true)
        return constraints
    }
}

#if os(iOS) || os(tvOS)
class TraitOverridingView: UIView {

    var overridenTraitCollection: UITraitCollection

    override init(frame: CGRect) {
        overridenTraitCollection = UITraitCollection()
        super.init(frame: frame)
    }

    convenience init() {
        self.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var traitCollection: UITraitCollection {
        return (superview as? TraitOverridingView)?.overridenTraitCollection ?? overridenTraitCollection
    }
}
#endif
