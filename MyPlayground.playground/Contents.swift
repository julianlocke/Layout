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
import UIKit
import PlaygroundSupport
import Layout

class MyViewController: UIViewController {

    private var mainLayout: Layout?

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.text = "Hello World!"
        view.addSubview(label)

        let green = UIView()
        green.backgroundColor = .green
        view.addSubview(green)

        mainLayout = Layout.make(rootView: view) { ctx in
            ctx.when(.horizontallyCompact) {
                ctx.when(.verticallyRegular) {
                    label.makeConstraints(
                        .center()
                    )
                }

                ctx.when(.verticallyCompact) {
                    label.makeConstraints(
                        .align(.centerX),
                        .align(.top, of: view.safeAreaLayoutGuide, offsetBy: 10)
                    )
                }

                green.makeConstraints(
                    .align(.centerX),
                    .align(.top, to: .bottom, of: label, offsetBy: 10),
                    .setSize(CGSize(width: 200, height: 200))
                )
            }
        }

        mainLayout?.setIsActive(true, traits: .horizontallyCompact, .verticallyRegular)

        self.view = view
    }
}

PlaygroundPage.current.liveView = MyViewController()
