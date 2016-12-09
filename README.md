# Layout

"Layout" is a library for iOS, macOS, and tvOS that allows you to easily and safely define readable layout constraints in code. It provides:

* Large set of layouts and operators that work on both `UIView` and `UILayoutGuide`.
* Layout manager to easily create, apply, and animate constraints based on `UITraitCollection` changes, or any other dynamic triggers. See [Examples](#examples).
* Type safe layouts. Trying to relate things like a view's `x` and `y` axis or its `left` and `leading` edges will generate errors at compile time.

Additionally, "Layout" provides a few other useful utilities.

* Syntactic sugar for combining `UITraitCollection`s. E.g. `.horizontally(.regular) && .idiom(.phone)`.
* Extensions for activating or deactivating `Sequence`s of constraints. E.g. `nextConstraints.activate`
* An API to efficiently activate a new set of constraints, diffing and applying only what's necessary. `view.updateConstraints(deactivate: oldConstraints, activate: newConstraints)` This is used implicitly by both `LayoutManager` and `DynamicLayoutManager`.

# Table of Contents
1. [Operators](#operators)
2. [Layouts](#layouts)
3. [Examples](#examples)

## Operators

### `==`

Use this operator to set some piece your layout equal to a constant, another layout, or another `UIView`/`UILayoutGuide`.

```swift
view.applyLayout(
    Layout.width == 100, // Sets view's width to 100.
    Layout.leading == otherView, // Sets view's leading edge to be equal to otherViews's leading edge.
    Layout.top == Layout.bottom(of: otherView) // Sets view's top to be equal to otherView's bottom.
)
```

### `>=` `<=`

Use these operators to define "greater than or equal to" or "less than or equal to" relations between a layout and either constant or another layout.

```swift
view.applyLayout(
    Layout.width >= 100,
    Layout.top >= Layout.bottom(of: otherView)
)
```

### `+` `-`

Use these operators to modify the `constant` of a layout.

```swift
view.applyLayout(
    Layout.leadingMargin + 20,
    Layout.trailingMargin - 20
)
```

### `~`

Use this operator to apply a `priority` to a layout.

```swift
view.applyLayout(
    Layout.centerY ~ UILayoutPriorityDefaultHigh
)
```

### `<-`

Use this operator to apply a debug `identifier` to a layout.

```swift
view.applyLayout(
    Layout.leading <- "Oh god why is this breaking :("
)
```

## Layouts

All `NSLayoutAttribute`s are supported natively, as well as many convenient composite layouts (like `size`, which combines `width` and `height`).

`left`, `left(of:)`, `leftMargin`, `leftMargin(of:)`, `leftToMargin`, `leading`, `leading(of:)`, `leadingMargin`, `leadingMargin(of:)`, `leadingToMargin`, `right`, `right(of:)`, `rightMargin`, `rightMargin(of:)`, `rightToMargin`, `trailing`, `trailing(of:)`, `trailingMargin`, `trailingMargin(of:)`, `trailingToMargin`, `top`, `top(of:)`, `topMargin`, `topMargin(of:)`, `topToMargin`, `firstBaseline`, `firstBaseline(of:)`, `bottom`, `bottom(of:)`, `bottomMargin`, `bottomMargin(of:)`, `bottomToMargin`, `lastBaseline`, `lastBaseline(of:)`, `centerX`, `centerX(of:)`, `centerXWithinMargins`, `centerXWithinMargins(of:)`, `centerY`, `centerY(of:)`, `centerYWithinMargins`, `centerYWithinMargins(of:)`, `centerToXWithinMargins`, `centerToYWithinMargins`, `center`, `center(of:)`, `centerWithinMargins`, `width`, `width(of:)`, `height`, `height(of:)`, `horizontal`, `horizontalToMargins`, `horizontalToLeadingTrailing`, `horizontalToLeadingTrailingMargins`, `vertical`, `verticalToMargins`, `horizontalToBaselines`, `flush`, `flush(with:)`, `flushToMargins`, `flushToMargins(with:)`, `size`, `size(of:)`

## Examples

### `applyLayout` Example

```swift
import UIKit
import Layout

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let green = UIView()
        green.backgroundColor = .green
        view.addSubview(green)
        green.applyLayout(
            Layout.size >= 100 ~ UILayoutPriorityDefaultHigh, // A square, at least 100 points in size, at a high priority.
            Layout.centerX, // Center green in its superview. Equivalent to: `Layout.centerX(of: view)`
            Layout.centerY == Layout.bottom(of: view) / 3 // Set the centerY of green to be a third of the way down the screen.
        )

        let red = UIView()
        red.backgroundColor = .red
        view.addSubview(red)
        red.applyLayout(
            Layout.left == green, // Set red's left to be equal to green's left.
            Layout.top == green, // Set red's top to be equal to green's top.
            Layout.size(of: green) / 2 // Set red's size (width and height) to be half of green's.
        )

        let blue = UIView()
        blue.backgroundColor = .blue
        view.addSubview(blue)
        blue.applyLayout(
            Layout.right, // Set blue's right to its superview's right.
            Layout.width == 75, // Set blue's width to 75.
            Layout.centerY == green, // Set blue's centerY to be equal to green's.
            Layout.height(of: green) * 2 // Set blue's height to twice green's height.
        )
    }
}
```

### `DynamicLayoutManager` Example

```swift
import UIKit
import Layout

class ViewController: UIViewController {
    var layouts: DynamicLayoutManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        layouts = DynamicLayoutManager(rootView: self.view)

        let green = UIView()
        green.backgroundColor = .green
        view.addSubview(green)

        let red = UIView()
        red.backgroundColor = .red
        green.addSubview(red)

        // Set up some constant constraints.
        green.applyLayout(Layout.center)
        red.applyLayout(Layout.center)

        // Set up some trait based constraints.
        // Use `createLayout` instead of `applyLayout` to not apply constraints immediately.

        // For horizontally regular phones:
        layouts.add(constraintsFor: .horizontally(.regular) && .idiom(.phone)) { ctx in
            ctx.add(green.createLayout(Layout.size == 300))
            ctx.add(red.createLayout(Layout.size(of: green) / 3))
        }

        // For horizontally compact phones:
        layouts.add(constraintsFor: .horizontally(.compact) && .idiom(.phone)) { ctx in
            ctx.add(green.createLayout(Layout.size == 200))
            ctx.add(red.createLayout(Layout.size(of: green) / 4))
        }

        // For horizontally regular ipads:
        layouts.add(constraintsFor: .horizontally(.regular) && .idiom(.pad)) { ctx in
            ctx.add(green.createLayout(Layout.size == 200))
        }

        // For horizontally compact ipads:
        layouts.add(constraintsFor: .horizontally(.compact) && .idiom(.pad)) { ctx in
            ctx.add(green.createLayout(Layout.size == 100))
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layouts?.updateTraitBasedConstraints() // Notify the layout manager that traits have changed.
                                               // This method takes an optional `UITraitCollection` and `CGSize`.
    }
}
```
