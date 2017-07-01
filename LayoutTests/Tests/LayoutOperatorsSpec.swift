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

@testable import Layout
import Nimble
import Quick

class LayoutOperatorsSpec: QuickSpec {

    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("LayoutOperatorsSpec") {
            var parentView: View!
            var view: View!

            beforeEach {
                parentView = View(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                view = View()

                parentView.addSubview(view)
            }

            afterEach {
                parentView = nil
                view = nil
            }

            context("plus") {
                it("adds the correct constant") {
                    view.immediatelyApplyLayout(
                        Layout.left + 10,
                        Layout.vertical,
                        Layout.right
                    )

                    expect(view.frame) == CGRect(x: 10, y: 0, width: 90, height: 100)
                }

                it("adds the correct constants") {
                    view.immediatelyApplyLayout(Layout.size + 10)
                    expect(view.frame.size) == CGSize(width: 110, height: 110)
                }
            }

            context("minus") {
                it("subtracts the correct constant") {
                    view.immediatelyApplyLayout(
                        Layout.left - 10,
                        Layout.vertical,
                        Layout.right
                    )

                    expect(view.frame) == CGRect(x: -10, y: 0, width: 110, height: 100)
                }

                it("subtracts the correct constants") {
                    view.immediatelyApplyLayout(Layout.size - 10)
                    expect(view.frame.size) == CGSize(width: 90, height: 90)
                }
            }

            context("multiply") {
                it("adds the correct multiplier") {
                    view.immediatelyApplyLayout(
                        Layout.center,
                        Layout.size * 2
                    )

                    expect(view.frame) == CGRect(x: -50, y: -50, width: 200, height: 200)
                }
            }

            context("divide") {
                it("adds the correct multiplier") {
                    view.immediatelyApplyLayout(
                        Layout.center,
                        Layout.size / 2
                    )

                    expect(view.frame) == CGRect(x: 25, y: 25, width: 50, height: 50)
                }
            }

            context("identifier") {
                it("adds an identifier") {
                    let identifier = "debug"
                    let constraints = view.createLayout(Layout.left <- identifier)
                    expect(constraints.count) == 1
                    expect(constraints[0].identifier) == identifier
                }

                it("has a lower priority than ==") {
                    let identifier = "debug"
                    let constraints = view.createLayout(Layout.left == Layout.right(of: parentView) <- identifier)
                    expect(constraints.count) == 1
                    expect(constraints[0].identifier) == identifier
                }

                it("has a lower priority than >=") {
                    let identifier = "debug"
                    let constraints = view.createLayout(Layout.left >= Layout.right(of: parentView) <- identifier)
                    expect(constraints.count) == 1
                    expect(constraints[0].identifier) == identifier
                }

                it("has a lower priority than <=") {
                    let identifier = "debug"
                    let constraints = view.createLayout(Layout.left >= Layout.right(of: parentView) <- identifier)
                    expect(constraints.count) == 1
                    expect(constraints[0].identifier) == identifier
                }
            }

            context("priority") {
                it("adds an identifier") {
                    let priority: UILayoutPriority = .defaultLow
                    let constraints = view.createLayout(Layout.left ~ priority)
                    expect(constraints.count) == 1
                    expect(constraints[0].priority) == priority
                }
            }

            context("equal") {
                it("allows constants") {
                    view.immediatelyApplyLayout(Layout.width == parentView.frame.width)
                    expect(view.frame.width) == parentView.frame.width
                }

                it("allows other views") {
                    view.immediatelyApplyLayout(Layout.width == parentView)
                    expect(view.frame.width) == parentView.frame.width
                }

                it("allows other layouts") {
                    view.immediatelyApplyLayout(Layout.width == Layout.width(of: parentView))
                    expect(view.frame.width) == parentView.frame.width
                }

                it("allows other layouts with multipliers") {
                    view.immediatelyApplyLayout(Layout.width == Layout.width(of: parentView) * 2)
                    expect(view.frame.width) == parentView.frame.width * 2
                }
            }

            context("greater than or equal") {
                it("allows constants") {
                    view.immediatelyApplyLayout(Layout.width >= parentView.frame.width)
                    expect(view.frame.width) == parentView.frame.width
                }

                it("allows other views") {
                    view.immediatelyApplyLayout(Layout.width >= parentView)
                    expect(view.frame.width) == parentView.frame.width
                }

                it("allows other layouts") {
                    view.immediatelyApplyLayout(Layout.width >= Layout.width(of: parentView))
                    expect(view.frame.width) == parentView.frame.width
                }

                it("allows other layouts with multipliers") {
                    view.immediatelyApplyLayout(Layout.width >= Layout.width(of: parentView) * 2)
                    expect(view.frame.width) == parentView.frame.width * 2
                }
            }

            context("less than or equal") {
                it("allows constants") {
                    view.immediatelyApplyLayout(Layout.width <= parentView.frame.width, Layout.width == 1_000 ~ UILayoutPriority(rawValue: 500))
                    expect(view.frame.width) == parentView.frame.width
                }

                it("allows other views") {
                    view.immediatelyApplyLayout(Layout.width <= parentView, Layout.width == 1_000 ~ UILayoutPriority(rawValue: 500))
                    expect(view.frame.width) == parentView.frame.width
                }

                it("allows other layouts") {
                    view.immediatelyApplyLayout(Layout.width <= Layout.width(of: parentView), Layout.width == 1_000 ~ UILayoutPriority(rawValue: 500))
                    expect(view.frame.width) == parentView.frame.width
                }

                it("allows other layouts with multipliers") {
                    view.immediatelyApplyLayout(Layout.width <= Layout.width(of: parentView) / 2, Layout.width == 1_000 ~ UILayoutPriority(rawValue: 500))
                    expect(view.frame.width) == parentView.frame.width / 2
                }
            }
        }
    }
}
