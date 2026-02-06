# Driver Portal UI – Implementation Plan

Front-end only, no backend. Mock data. Goal: clean, interactive, polished APK.

---

## Requirements Summary

| Feature | Description |
|--------|-------------|
| **Bottom nav** | Shopify-app vibe: clean, modern. Icon for settings → opens drawer (Settings + History) |
| **Home** | Map as main view (Google Maps with provided API key) |
| **Online/Offline** | Toggle bottom-left, near navbar. When **Online** → show ride offer with Accept/Decline |
| **Route screen** | After Accept: map with pickup + destination + route line; small bottom popup with trip info (name, price, etc.) |
| **Prices** | Fixed but displayed as adjustable via config/constants (e.g. in Settings) |

**Deliverable:** APK, clean UI, good spacing, smooth navigation, polished feel.

---
 
## Design mockups

| Mode   | Mockup |
|--------|--------|
| **Light** | https://res.cloudinary.com/dwcnliksx/image/upload/v1770399834/sc1_lrwbtt.png |
| **Dark**  | https://res.cloudinary.com/dwcnliksx/image/upload/v1770399835/sc2_hfto6e.png |

---

## Tech Stack

- **Flutter** (existing project)
- **Maps:** `google_maps_flutter` (API key provided; Mapbox alternative possible later)
- **State:** Lightweight (e.g. `ValueNotifier` / `ChangeNotifier` or Provider) for: online state, current ride offer, nav index
- **Navigation:** Named routes or GoRouter
- **Config:** `lib/core/config/app_constants.dart` for base price, app name; editable from Settings UI

---

## Implementation Order

### 1. Project setup
- [x] Plan document (this file)
- [ ] Dependencies: `google_maps_flutter`, minimal state/nav
- [ ] Android: add Google Maps API key in `AndroidManifest.xml`
- [ ] iOS: add key in `Info.plist` (for later)
- [ ] App theme: clean, modern (primary color, typography, card style)
- [ ] Constants: default price, app name, mock trip data

### 2. Shell: bottom nav + drawer
- [ ] Main shell with bottom navigation (e.g. Home only tab + settings icon that opens drawer)
- [ ] Drawer: menu icon in app bar or as nav item → opens drawer with **Settings** and **History**
- [ ] Placeholder screens: Settings, History (list of past trips – mock)

### 3. Home screen
- [ ] Full-screen map (Google Maps), one default camera position
- [ ] Online/Offline toggle: bottom-left, above/beside bottom nav, clear states
- [ ] When **Offline**: no ride card
- [ ] When **Online**: show mock “Ride offer” card (pickup, destination, price) with **Accept** / **Decline**
- [ ] Accept → navigate to Route screen with trip payload

### 4. Route screen
- [ ] Map with pickup and destination markers + polyline (visual route)
- [ ] Bottom sheet / small popup: trip info (rider name, pickup, destination, fixed price from constants)
- [ ] Back or “Complete” to return home (mock)

### 5. Settings & config
- [ ] Settings screen: list items (e.g. “Fare per km”, “Base fare”) – values from `app_constants.dart`
- [ ] Display as editable (TextField or similar); persist in memory or SharedPreferences so price “feels” adjustable (no real backend)
- [ ] Use these values when displaying price on ride offer and route popup

### 6. Polish & APK
- [ ] Consistent spacing (e.g. 16/24 grid), rounded corners, shadows
- [ ] Smooth transitions (page route animations, bottom sheet)
- [ ] Build release APK: `flutter build apk --release`

---

## File Structure (target)

```
lib/
├── main.dart
├── core/
│   ├── config/
│   │   └── app_constants.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── router/
│       └── app_router.dart
├── data/
│   └── mock/
│       └── mock_trips.dart
├── presentation/
│   ├── shell/
│   │   ├── main_shell.dart
│   │   ├── app_drawer.dart
│   │   └── bottom_nav.dart
│   ├── home/
│   │   ├── home_screen.dart
│   │   ├── map_view.dart
│   │   ├── online_toggle.dart
│   │   └── ride_offer_card.dart
│   ├── route/
│   │   ├── route_screen.dart
│   │   ├── route_map.dart
│   │   └── trip_info_sheet.dart
│   ├── settings/
│   │   └── settings_screen.dart
│   └── history/
│       └── history_screen.dart
└── models/
    └── trip.dart
```

---

## Map API Key

- **Android:** `AndroidManifest.xml` – already noted:
  `com.google.android.geo.API_KEY` = `AIzaSyA35G25e2RNvIx4I9acu2rqIdZw32Yz9C8`
- **iOS:** Add same key in `Info.plist` when building for iOS.

---

## Notes

- All trip/ride data is mocked (e.g. `mock_trips.dart`).
- “History” is mock list from `MockTrips.history`.
- Prices shown on offer and route come from mock data; Settings screen shows Base fare / Per km as “adjustable” (config feel).
- **Map API key:** Android uses `com.google.android.geo.API_KEY` in `AndroidManifest.xml`. For iOS, add the key in `ios/Runner/AppDelegate.swift` via `GMSServices.provideAPIKey("...")` when building for iOS.
