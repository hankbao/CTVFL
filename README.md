# CTFVL: Compile-Time Visual Format Language

CTVFL is a tiny framework offers compile-time safe Visual Format Langauge to
make Auto Layout painless on Apple platforms.

## Cautions

Since I built this framework with only a few hours, it is poor tested now.
A bunch of systematically designed test cases would be completed in the future.

## Examples

### Making Native Cocoa Constraints

```swift
// [button]-[textField]
let constraint0 = withVFL(H: button - textField, options: [])

// [button(>=50)]
let constraint1 = withVFL(H: button.that(>=50))

// |-50-[purpleBox]-50-|
let constraint2 = withVFL(H: |-50 - purpleBox - 50-|)

// V:[topField]-10-[bottomField]
let constraint3 = withVFL(V: topField - 10 - bottomField)

// [maroonView][blueView]
let constraint4 = withVFL(H: maroonView | blueView)

// [button(100@20)]
let constraint5 = withVFL(H: button.that(200 ~ 20))

// [button1(==button2)]
let constraint6 = withVFL(H: button1.that(==button2))

// [flexibleButton(>=70,<=100)]
let constraint7 = withVFL(H: flexibleButton.that(>=70, <=100))

// |-[find]-[findNext]-[findField(>=20)]-|
let constraint8 = withVFL(H: |-find - findNext - findField.that(>=20)-|)
```

### Making and Installing Constraints with a Collective Control Point

Wrapping `withVFL` function calls with `constrain` function's closure makes
the framework installs the generated constraints and encapsultes them in
a `CTVFLConstraintGroup` instance. You can control the whole group of
generated constriants with this instance.

```swift
var view1VerticalConstraints = [NSLayoutConstraint]!

let constraintGroup = constrain {
    withVFL(H: |-view1 - 100 - view2-|)

    view1VerticalConstraints = withVFL(V: |-view1-|)

    withVFL(V: |-view2-|)
}

view1VerticalConstraints.forEach({$0.isActive = false})
```

```swift
// ... something happened

if !constraintGroup.areAllAcrive {
    constraintGroup.setActive(true)
}
```

```swift
// ... something happened

constraintGroup.uninstall()
```

## Handling Corner Cases

In some versions of iOS, you shall not set 
`translatesAutoresizingMaskIntoConstraints` to `false` for `UITableViewCell`'s
`containerView` or `UICollectionViewCell`'s `containerView`. But once you
made constraints and installed them with the `constrain` function, the
framework automatically searches the nearest common superview for each
`withVFL` call and sets its `translatesAutoresizingMaskIntoConstraints`
to `false`. To get rid of it, you can use the following code.

```swift
ignoresTranslatingAutoresizingMaskIntoConstraints = true
```

This global variable resets to `false` each time the `constrain` closure
 ends.

## Helping Debugging

The framework mangles each view's name in the internal visual format string
by generating a random string for it, which is quite bad for debugging.

To help your debugging, you can use `setVariableName(_: for:)` function to
set a human-readable variable name for any view.

```swift
constrain(
    setVariableName("view1", for: view1)
)
```

Calling `setVariableName(_: for:)` outsides a `constrain` closure doesn't
have any work.
