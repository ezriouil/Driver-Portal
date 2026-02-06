# Driver Portal UI

<p align="center">
  <strong>Flutter driver app</strong> — Map, ride offers, route view & settings
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Dart-3.10+-0175C2?logo=dart" alt="Dart"/>
  <img src="https://img.shields.io/badge/GetX-State%20%26%20Routing-8B0000" alt="GetX"/>
</p>

---

## About

**Driver Portal UI** is a Flutter mobile app for drivers. It provides a map-based home screen, online/offline toggle, ride offer cards with Accept/Decline, a route screen with trip details, and a settings screen for fare configuration. The app is **front-end only** and uses **mock data** — no backend required. Built for a clean, interactive experience suitable for demos or as a base for a real driver product.

---

## Features

| Feature | Description |
|--------|-------------|
| **Map home** | Full-screen Google Map with custom style, zoom controls, and default camera (e.g. Rabat). |
| **Online / Offline** | Toggle bottom-left; when **Online**, a mock ride offer card appears with Accept / Decline. |
| **Ride offer card** | Shows rider info, pickup, destination, price; Accept navigates to the route screen. |
| **Route screen** | Map with pickup and destination markers, route polyline, and a draggable trip info bottom sheet. |
| **Drawer** | Home, Settings, History; opens from the settings icon in the bottom bar. |
| **Settings** | Base fare and per-km rate (editable via bottom sheets); dark mode toggle. |
| **History** | List of past trips (mock); tap a card to open the route view for that trip. |
| **Splash** | Logo screen for 2 seconds, then navigates to home. |
| **Theming** | Light and dark themes with shared colors and typography (Open Sans). |

---

## Light mode mockup

<p align="center">
  <img src="https://res.cloudinary.com/dwcnliksx/image/upload/v1770399834/sc1_lrwbtt.png" alt="Driver Portal – Light mode"/>
</p>

---

## Dark mode mockup

<p align="center">
  <img src="https://res.cloudinary.com/dwcnliksx/image/upload/v1770399835/sc2_hfto6e.png" alt="Driver Portal – Dark mode"/>
</p>

---

## Tech stack

| Layer | Technology |
|-------|------------|
| **Framework** | Flutter (SDK ^3.10.7) |
| **State & routing** | GetX (controllers, bindings, named routes) |
| **Map** | google_maps_flutter (styled map, markers, polyline) |
| **Persistence** | shared_preferences (e.g. units, theme preference) |
| **UI** | Material 3, custom theme (app_constants.dart), iconsax_flutter, lottie |
| **Config** | app_constants.dart (colors, defaults), app_config.dart (base fare, per-km rate) |

**Main packages:** `get`, `google_maps_flutter`, `shared_preferences`, `lottie`, `iconsax_flutter`, `avatar_glow`.

---

## Project structure

```
lib/
├── main.dart
├── core/
│   ├── config/          # app_constants, app_config, map_style
│   ├── routes/          # app_routes, app_pages (GetX)
│   ├── theme/           # theme_app, theme_controller, custom_theme/*
│   ├── utils/           # app_bottom_sheet
│   └── widgets/         # custom buttons, text field, glass_circle_button, lottie_loading_wrapper
├── data/
│   └── mock/            # mock_trips.dart
├── domain/
│   └── models/          # trip_entity.dart, LatLngPoint
└── presentation/
    ├── splash/          # splash_screen
    ├── home/            # home_screen, home_controller, ride_offer_card
    ├── route/           # route_screen, route_controller, trip_info_sheet
    ├── settings/        # settings_screen, settings_controller, settings_setting_tile
    └── history/         # history_screen, history_controller, history_trip_card
```

---

## Getting started

### Prerequisites

- **Flutter 3.x** (Dart 3.10+)
- **Android Studio / VS Code** (optional)
- **Google Maps API key** (for Android and iOS)

### Clone & run

```bash
git clone https://github.com/ezriouil/Driver-Portal.git
cd Driver-Portal
flutter pub get
flutter run
```

### Map API key

- **Android:** Set `com.google.android.geo.API_KEY` in `android/app/src/main/AndroidManifest.xml`.
- **iOS:** Add the same key in `ios/Runner/Info.plist` (or via `GMSServices.provideAPIKey` in AppDelegate) when building for iOS.

### Build release APK

```bash
flutter build apk --release
```

The APK is generated in `build/app/outputs/flutter-apk/`.

---

## Configuration

- **Default map:** Coordinates and zoom are in `lib/core/config/app_constants.dart` (defaultLat, defaultLng, defaultZoom).
- **Fare defaults:** Base fare and per-km rate in `app_constants.dart`; editable at runtime in Settings and stored in memory (AppConfig). Optional persistence can be added via SharedPreferences.

---

## License

This project is for demonstration and portfolio use. Replace with your own license if needed.
