// Default ElevatedButton theme. Used by [ThemeApp].

import 'package:driver_portal_ui/core/config/app_constants.dart';
import 'package:flutter/material.dart';

class CustomElevatedButtonTheme {
  CustomElevatedButtonTheme._();

  /// Elevated Button For Light Theme
  static ElevatedButtonThemeData lightElevatedButtonTheme =
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 4,
              shadowColor: AppConstants.PRIMARY,
              backgroundColor: AppConstants.PRIMARY,
              foregroundColor: AppConstants.WHITE,
              disabledBackgroundColor: AppConstants.GRAY_DARK,
              disabledForegroundColor: AppConstants.GRAY_DARK,
              side: BorderSide(
                  color: AppConstants.PRIMARY.withValues(alpha: 0.8)),
              padding: const EdgeInsets.symmetric(vertical: 8),
              textStyle: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontFamily: "Open_sans_bold",
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4))));

  /// Elevated Button For Dark Theme
  static ElevatedButtonThemeData darkElevatedButtonTheme =
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 4,
              shadowColor: AppConstants.SECONDARY,
              backgroundColor: AppConstants.SECONDARY,
              foregroundColor: AppConstants.WHITE,
              disabledBackgroundColor: AppConstants.GRAY_LIGHT,
              disabledForegroundColor: AppConstants.GRAY_LIGHT,
              side: BorderSide(
                  color: AppConstants.SECONDARY.withValues(alpha: 0.8)),
              padding: const EdgeInsets.symmetric(vertical: 8),
              textStyle: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontFamily: "Open_sans_bold"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4))));
}
