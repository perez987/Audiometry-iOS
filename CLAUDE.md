# CLAUDE.md

## Repository overview

- iPhone and iPad app built with SwiftUI
- Swift 6
- Minimum deployment target is iOS 18.0
- Xcode 26 or 27
- Single storage implementation: `PatientDataStore` persists patient data to JSON in the app's Application Support directory
- No Core Data path remains in the current project state

## Important files

- `Audiometry/AudiometryApp.swift` — app entry point
- `Audiometry/Views/ContentView.swift` — main form and calculation UI
- `Audiometry/Model/PatientNavigationView.swift` — SwiftUI navigation view for patient actions, search, print, and language menu
- `Audiometry/Model/PatientDataStore.swift` — persistence and sample-data bootstrap
- `Audiometry/Model/PatientData.swift` — persisted patient model
- `Audiometry/Model/AudiometryCalculations.swift` — hearing-loss, SAL, and ELI logic
- `Audiometry/Model/PrintReportHelpers.swift` — PDF generation and iOS printing
- `Audiometry/<language>.lproj/Localizable.strings` — localized UI strings

## Working rules for agents

- Keep changes small and targeted
- Prefer updating existing SwiftUI views and models instead of introducing new architecture
- Preserve the single-store flow centered on `PatientDataStore.shared`
- When changing user-visible text, update all localization files instead of hardcoding strings
- Keep iPhone and iPad behavior intact; this is not a cross-platform target

## Validation

- Build with:
  - `xcodebuild -project Audiometry.xcodeproj -scheme Audiometry -destination 'generic/platform=iOS Simulator' build`
- There is no separate test target in the repository at the moment

## Persistence details

- Patient records live in the app's Application Support directory as `Audiometry/patients.json`
- The bundled sample file is copied on first run when no saved file exists
