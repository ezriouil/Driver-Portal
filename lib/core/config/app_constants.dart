// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

/// App-wide constants: name, defaults, map defaults, and shared colors.
/// Used by theme, config, and UI for light/dark consistency.
class AppConstants {
  AppConstants._();

  // --- App & fare ---
  static const String appName = 'Driver Portal';
  static const String defaultBaseFare = '5.00';
  static const String currencySymbol = ' MAD';
  static const String defaultPerKmRate = '2.50';

  // --- Map defaults (e.g. Rabat) ---
  static const double defaultLat = 34.0209;
  static const double defaultLng = -6.8416;
  static const double defaultZoom = 14.0;

  // --- Base colors ---
  static const WHITE = Color(0xFFF7F7F7);
  static const BLACK = Color.fromARGB(255, 1, 19, 36);
  static const TRANSPARENT = Color(0x00000000);

  // --- Primary / secondary (buttons, accents) ---
  static const PRIMARY = Color(0xFFC62828);
  static const SECONDARY = Color(0xFF1565C0);

  // --- Surfaces ---
  static const GRAY_LIGHT = Color.fromARGB(255, 240, 240, 242);
  static const GRAY_DARK = Color.fromARGB(255, 38, 48, 68);

  // --- Status (online/offline, errors) ---
  static const RED_LIGHT = Color(0xFFFF6B6B);
  static const RED_DARK = Color(0xFFC62828);
  static const GREEN_LIGHT = Color(0xFF66BB6A);
  static const GREEN_DARK = Color(0xFF064420);

  // --- Accents (optional) ---
  static const BLUE_LIGHT = Color(0xFF42A5F5);
  static const BLUE_DARK = Color(0xFF1565C0);
  static const YELLOW_LIGHT = Color(0xFFFFD54F);
  static const YELLOW_DARK = Color(0xFFF9A825);
}
