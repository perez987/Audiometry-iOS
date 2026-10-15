# Xcode console messages

This page explains messages that show up in the Xcode console while running Audiometry in the simulator or in a debug build. None of them need a code change. They come from iOS itself (the simulator, the keyboard, pointer support and gestures), not from the app.

Audiometry is pure SwiftUI. It has no `UIViewRepresentable`, `NSLayoutConstraint` or gesture code. The only UIKit pieces are `UIPrintInteractionController` (`PrintReportHelpers.swift`) and the JSON loading in `PatientDataStore.swift`, and neither one produces these messages.

## Summary

| Message | Where it comes from | Fix needed? |
|---|---|---|
| `non-launching port is incompatible with service identifier "com.apple.PointerUI.pointeruid.default-service"` | iPad pointer support failing to connect to a system service. This is common in the simulator. | No |
| `cannot add handler to 0 from 0 - dropping` | Internal event/accessibility routing. It shows up in almost every SwiftUI app. | No |
| `isKeyboardMinorEdgeWidth / keyboardVerticalSizeClass / keyboardHorizontalSizeClass / currentHandBias / currentHeight may only be set for UIKBDynamicRenderFactory, changes not saved` | The keyboard switching layouts. The age and dB fields (`ContentView.swift`) use `.numberPad` and `.decimalPad`, while the name and job fields use the normal keyboard, and each switch logs this. | No. It's harmless. |
| `Gesture: System gesture gate timed out.` | A system gesture timeout, usually because the simulator or a debug build is slow the first time the keyboard appears. | No, unless the UI actually freezes on a device |
| `Unable to simultaneously satisfy constraints` | Almost certainly the iOS keyboard. On iPad the shortcuts bar above the keyboard has conflicting Auto Layout constraints (a long-standing UIKit bug). UIKit removes one constraint and carries on, so nothing looks wrong. | Almost certainly no. The app adds no constraints of its own. |

## Checking a constraint warning

The `Unable to simultaneously satisfy constraints` message is followed by a list of the constraints involved. Read that list to see where the warning comes from:

- If it includes classes like `SystemInputAssistantView`, `_UIButtonBarStackView`, `_UIRemoteKeyboardPlaceholderView` or `TUIKeyboard…`, it's the keyboard and you can ignore it.
- If it names a view from the app's own code, it's worth looking into.

## Hiding the noise

You can set `OS_ACTIVITY_MODE=disable` in the scheme (Edit Scheme → Run → Arguments → Environment Variables). This isn't recommended, because it also hides your own `os_log`/`Logger` output and real errors. It's better to filter the Xcode console by the app's subsystem or process.

## Workarounds not worth applying

A few of these messages could be avoided with workarounds, but none are worth it:

- Adding a "Done" button above the number pads with `ToolbarItemGroup(placement: .keyboard)` is itself known to trigger this same constraint warning.
- Removing the iPad shortcuts bar would need a UIKit `inputAssistantItem` hack, which goes against keeping the app pure SwiftUI.

The messages appear in the simulator and in debug builds but don't affect how the app behaves.
