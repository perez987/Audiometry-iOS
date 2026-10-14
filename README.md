# Audiometry for iOS and iPadOS

![Platform](https://img.shields.io/badge/iOS%20and%20iPadOS-18%2B-orange.svg)
![Swift](https://img.shields.io/badge/Swift-6.0-9494ff.svg)
![Xcode](https://img.shields.io/badge/Xcode-26%20or%2027-lavender.svg)

## SwiftUI audiometry app for iPhone and iPad

Audiometry is a SwiftUI application for capturing patient hearing test data, calculating hearing-loss results, and printing patient reports on iPhone and iPad. Patient data is stored locally as JSON through `PatientDataStore`.

## Requirements

- Xcode 26 or Xcode 27
- Swift 6
- iOS 18 or later
- iPhone or iPad device or simulator

## Features

- Patient data entry for name, age, and occupation
- Audiometric input for both ears at 500, 1000, 2000, 4000, and 8000 Hz
- Hearing loss assessment calculations
- SAL and ELI index calculations with categorized results
- Patient save, update, delete, search, and previous/next navigation
- Patient report preview and AirPrint printing
- Localized UI in English, Spanish, French, and Italian

## Data storage

Patient records are saved to `patients.json` in the app's Application Support directory. On first launch, the bundled sample data is copied there if no patient database exists yet.

## Project structure

- `Audiometry/AudiometryApp.swift` — SwiftUI app entry point
- `Audiometry/Views/ContentView.swift` — patient editing and calculation UI
- `Audiometry/Model/PatientDataStore.swift` — JSON-backed persistence
- `Audiometry/Model/PatientNavigationView.swift` — patient actions, search, navigation, and language menu
- `Audiometry/Model/AudiometryCalculations.swift` — hearing-loss, SAL, and ELI calculations
- `Audiometry/<language>.lproj/Localizable.strings` — localized strings

## Build

Open `Audiometry.xcodeproj` in Xcode, select the `Audiometry` scheme, and choose an iPhone or iPad device or simulator destination.

Command-line simulator build:

```bash
xcodebuild -project Audiometry.xcodeproj -scheme Audiometry -destination 'generic/platform=iOS Simulator' build
```

The project has no separate test target.
