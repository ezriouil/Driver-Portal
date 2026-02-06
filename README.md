# Driver Portal UI

Flutter app for drivers: map, online/offline toggle, ride offers, route screen, settings. Front-end only with mock data.

## Getting Started

- Flutter 3.x required. Clone, then run `flutter pub get` and `flutter run`.
- [Flutter documentation](https://docs.flutter.dev/)

---

## Implementation Plan (summary)

Front-end only, no backend. Mock data. Goal: clean, interactive, polished APK.

### Requirements

| Feature | Description |
|--------|-------------|
| **Bottom nav** | Clean, modern. Icon for settings → opens drawer (Settings + History) |
| **Home** | Map as main view (Google Maps with provided API key) |
| **Online/Offline** | Toggle bottom-left. When **Online** → show ride offer with Accept/Decline |
| **Route screen** | Map with pickup + destination + route line; bottom popup with trip info |
| **Prices** | Fixed but displayed as adjustable via config (e.g. in Settings) |

### Design mockups

- **Light mode:** [mockup](https://res.cloudinary.com/dwcnliksx/image/upload/v1770399834/sc1_lrwbtt.png)
- **Dark mode:** [mockup](https://res.cloudinary.com/dwcnliksx/image/upload/v1770399835/sc2_hfto6e.png)

### Tech stack

- **Flutter**, **GetX** (state + routing), **google_maps_flutter**, **shared_preferences**, **lottie**, **iconsax_flutter**. Config in `app_constants.dart` and `app_config.dart`.

### Map API key

- **Android:** `AndroidManifest.xml` – `com.google.android.geo.API_KEY`
- **iOS:** Add key in `Info.plist` when building for iOS.
