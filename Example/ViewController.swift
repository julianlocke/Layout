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
import Layout

class ViewController: UIViewController {
    var layouts: DynamicLayoutManager!
    var staticLayouts: LayoutManager<String>!

    override func viewDidLoad() {
        super.viewDidLoad()

        layouts = DynamicLayoutManager(rootView: self.view)
        staticLayouts = LayoutManager(rootView: self.view)

        let green = UIView()
        green.backgroundColor = .green
        view.addSubview(green)

        let red = UIView()
        red.backgroundColor = .red
        green.addSubview(red)

        staticLayouts["big"] = red.createLayout(
            Layout.flush
        )

        staticLayouts["small"] = red.createLayout(
            Layout.size / 2,
            Layout.center
        )

        staticLayouts.active = "big"

        green.applyLayout(Layout.center)

        layouts.add(constraintsMatching: .horizontally(.regular) && .idiom(.phone)) { ctx in
            ctx.add(green.createLayout(Layout.size == 300))
        }

        layouts.add(constraintsMatching: .horizontally(.compact) && .idiom(.phone)) { ctx in
            ctx.add(green.createLayout(
                Layout.size == 200
                ))
        }

        layouts.add(constraintsMatching: .horizontally(.regular) && .idiom(.pad)) { ctx in
            ctx.add(green.createLayout(
                Layout.size == 200
            ))
        }

        layouts.add(constraintsMatching: .horizontally(.compact) && .idiom(.pad)) { ctx in
            ctx.add(green.createLayout(
                Layout.size == 100
            ))
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layouts?.updateTraitBasedConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: 5, animations: {
            self.staticLayouts.active = "small"
        })
    }
}
