// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

/// App-wide config and color constants. Supports light/dark theme.
class AppConstants {
  AppConstants._();

  static const String appName = 'Driver Portal';
  static const String defaultBaseFare = '5.00';
  static const String currencySymbol = ' MAD';
  static const String defaultPerKmRate = '2.50';
  static const double defaultLat = 34.0209;
  static const double defaultLng = -6.8416;
  static const double defaultZoom = 14.0;

  /*___________________ BASIC COLORS _____________________*/
  static const WHITE = Color(0xFFF7F7F7);
  static const BLACK = Color.fromARGB(255, 1, 19, 36);
  static const TRANSPARENT = Color(0x00000000);

  /*__________________ PRIMARY COLOR ______________________*/
  static const PRIMARY = Color(0xFFC62828);

  /*__________________ SECONDARY COLOR ______________________*/
  static const SECONDARY = Color(0xFF1565C0);

  /*__________________ COLORS ______________________*/
  static const GRAY_LIGHT = Color.fromARGB(255, 240, 240, 242);
  static const GRAY_DARK = Color.fromARGB(255, 38, 48, 68);

  /*__________________ RED COLORS ______________________*/
  static const RED_LIGHT = Color(0xFFFF6B6B);
  static const RED_DARK = Color(0xFFC62828);

  /*__________________ PURPLE COLORS ______________________*/
  static const PURPLE_LIGHT = Color(0xFFBA68C8);
  static const PURPLE_DARK = Color(0xFF7B1FA2);

  /*__________________ BLUE COLORS ______________________*/
  static const BLUE_LIGHT = Color(0xFF42A5F5);
  static const BLUE_DARK = Color(0xFF1565C0);

  /*__________________ YELLOW COLORS ______________________*/
  static const YELLOW_LIGHT = Color(0xFFFFD54F);
  static const YELLOW_DARK = Color(0xFFF9A825);

  /*__________________ GREEN COLORS ______________________*/
  static const GREEN_LIGHT = Color(0xFF66BB6A);
  static const GREEN_DARK = Color(0xFF064420);

  /*__________________ ORANGE COLORS ______________________*/
  static const ORANGE_LIGHT = Color(0xFFFFA726);
  static const ORANGE_DARK = Color(0xFFE65100);

  /*__________________ OTHERS COLORS ______________________*/
  static const GOLD = Color(0xFFEABF00);
}
