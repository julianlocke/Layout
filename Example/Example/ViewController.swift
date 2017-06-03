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

import Layout
import UIKit

class ViewController: UIViewController {
    var layouts: DynamicLayoutManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        layouts = DynamicLayoutManager(rootView: view)

        let green = UIView()
        green.backgroundColor = .green
        view.addSubview(green)

        let red = UIView()
        red.backgroundColor = .red
        green.addSubview(red)

        // Set up some constant constraints.
        green.applyLayout(Layout.center)

        // Set up some trait based constraints.

        layouts.add(constraintsFor: .idiom(.phone)) {
            green.createLayout(Layout.size == 300)

            red.createLayout(Layout.center(of: green))

            layouts.add(constraintsFor: .horizontally(.regular)) {
                red.createLayout(Layout.size(of: green) / 2)
            }

            layouts.add(constraintsFor: .horizontally(.compact)) {
                red.createLayout(Layout.size(of: green) / 4)
            }
        }

        layouts.add(constraintsFor: .idiom(.pad)) {
            green.createLayout(Layout.size == 200)

            red.createLayout(
                Layout.top(of: green),
                Layout.left(of: green)
            )

            layouts.add(constraintsFor: .horizontally(.regular)) {
                red.createLayout(Layout.size(of: green) / 3)
            }

            layouts.add(constraintsFor: .horizontally(.compact)) {
                red.createLayout(Layout.size(of: green) / 5)
            }
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        layouts.updateTraitBasedConstraints(alongside: coordinator)
    }
}
