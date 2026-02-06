import 'package:driver_portal_ui/core/config/app_constants.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButtonTheme {
  CustomOutlinedButtonTheme._();

  /// Outlined Button Light Theme
  static final OutlinedButtonThemeData lightOutlinedButtonTheme =
      OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              elevation: 4,
              shadowColor: AppConstants.PRIMARY,
              backgroundColor: AppConstants.TRANSPARENT,
              foregroundColor: AppConstants.PRIMARY,
              disabledBackgroundColor: AppConstants.TRANSPARENT,
              disabledForegroundColor: AppConstants.TRANSPARENT,
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

  /// Outlined Button Dark Theme
  static final OutlinedButtonThemeData darkOutlinedButtonTheme =
      OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              elevation: 4,
              shadowColor: AppConstants.SECONDARY,
              backgroundColor: AppConstants.TRANSPARENT,
              foregroundColor: AppConstants.SECONDARY,
              disabledBackgroundColor: AppConstants.TRANSPARENT,
              disabledForegroundColor: AppConstants.TRANSPARENT,
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
