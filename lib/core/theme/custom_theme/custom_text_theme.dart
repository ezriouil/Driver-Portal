// TextTheme for light/dark. Used by [ThemeApp].

import 'package:driver_portal_ui/core/config/app_constants.dart';
import 'package:flutter/material.dart';

class CustomTextTheme {
  CustomTextTheme._();

  /// Text For Light Theme
  static final TextTheme lightTextTheme = TextTheme(
    headlineSmall: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w600, color: AppConstants.BLACK, fontFamily: "Open_sans_bold"),
    headlineMedium: const TextStyle().copyWith(fontSize: 22.0, fontWeight: FontWeight.w600, color: AppConstants.BLACK, fontFamily: "Open_sans_bold"),
    headlineLarge: const TextStyle().copyWith(fontSize: 30.0, fontWeight: FontWeight.bold, color: AppConstants.BLACK, fontFamily: "Open_sans_bold"),

    titleSmall: const TextStyle().copyWith(fontSize: 13.0, fontWeight: FontWeight.w400, color: AppConstants.BLACK, fontFamily: "Open_sans_regular"),
    titleMedium: const TextStyle().copyWith(fontSize: 13.0, fontWeight: FontWeight.w500, color: AppConstants.BLACK, fontFamily: "Open_sans_regular"),
    titleLarge: const TextStyle().copyWith(fontSize: 13.0, fontWeight: FontWeight.bold, color: AppConstants.BLACK, fontFamily: "Open_sans_bold"),

    bodySmall: const TextStyle().copyWith(fontSize: 11.0, fontWeight: FontWeight.w500, color: AppConstants.GRAY_DARK, fontFamily: "Open_sans_regular"),
    bodyMedium: const TextStyle().copyWith(fontSize: 11.0, fontWeight: FontWeight.normal, color: AppConstants.BLACK, fontFamily: "Open_sans_regular"),
    bodyLarge: const TextStyle().copyWith(fontSize: 11.0, fontWeight: FontWeight.bold, color: AppConstants.BLACK, fontFamily: "Open_sans_regular"),
  );

  /// Text For Dark Theme
  static final TextTheme darkTextTheme = TextTheme(
    headlineSmall: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w600, color: AppConstants.WHITE, fontFamily: "Open_sans_bold"),
    headlineMedium: const TextStyle().copyWith(fontSize: 22.0, fontWeight: FontWeight.w600, color: AppConstants.WHITE, fontFamily: "Open_sans_bold"),
    headlineLarge: const TextStyle().copyWith(fontSize: 30.0, fontWeight: FontWeight.bold, color: AppConstants.WHITE, fontFamily: "Open_sans_bold"),

    titleSmall: const TextStyle().copyWith(fontSize: 13.0, fontWeight: FontWeight.w400, color: AppConstants.WHITE, fontFamily: "Open_sans_regular"),
    titleMedium: const TextStyle().copyWith(fontSize: 13.0, fontWeight: FontWeight.w500, color: AppConstants.WHITE, fontFamily: "Open_sans_regular"),
    titleLarge: const TextStyle().copyWith(fontSize: 13.0, fontWeight: FontWeight.bold, color: AppConstants.WHITE, fontFamily: "Open_sans_bold"),

    bodySmall: const TextStyle().copyWith(fontSize: 11.0, fontWeight: FontWeight.w500, color: AppConstants.GRAY_LIGHT, fontFamily: "Open_sans_regular"),
    bodyMedium: const TextStyle().copyWith(fontSize: 11.0, fontWeight: FontWeight.normal, color: AppConstants.WHITE, fontFamily: "Open_sans_regular"),
    bodyLarge: const TextStyle().copyWith(fontSize: 11.0, fontWeight: FontWeight.bold, color: AppConstants.WHITE, fontFamily: "Open_sans_regular"),
  );
}