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

import UIKit
import Layout

class ViewController: UIViewController {

    private let label: UILabel = {
        let label = UILabel()
        label.text = "Hello, world!"
        return label
    }()

    private let green: UIView = {
        let green = UIView()
        green.backgroundColor = .green
        return green
    }()

    private var layout: Layout?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(green)

        layout = Layout { ctx in
            green.makeConstraints(
                .center()
            )

            label.makeConstraints(
                .align(.centerX),
                .align(.top, to: .bottom, of: green, offsetBy: 10)
            )

            ctx.when(.verticallyCompact) {
                green.makeConstraints(
                    .setRelative(.width, to: 0.75),
                    .setRelative(.height, to: 0.15, attribute: .width)
                )
            }

            ctx.when(.verticallyRegular) {
                green.makeConstraints(
                    .setRelative(.width, to: 0.5),
                    .setRelative(.height, to: 0.5, attribute: .width)
                )
            }
        }

        layout?.setIsActive(true, traits: view.traitCollection)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.layout?.updateActiveConstraints(with: self.traitCollection)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
