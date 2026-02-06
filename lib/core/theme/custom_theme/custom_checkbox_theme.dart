// Checkbox theme for light/dark. Used by [ThemeApp].

import 'package:driver_portal_ui/core/config/app_constants.dart' show AppConstants;
import 'package:flutter/material.dart';

class CustomCheckboxTheme {
  CustomCheckboxTheme._();

  /// Checkbox For Light Theme
  static final CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      checkColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppConstants.WHITE;
        } else {
          return AppConstants.BLACK;
        }
      }),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppConstants.PRIMARY;
        } else {
          return AppConstants.TRANSPARENT;
        }
      }));

  /// Checkbox For Dark Theme
  static final CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      checkColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppConstants.BLACK;
        } else {
          return AppConstants.WHITE;
        }
      }),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppConstants.SECONDARY;
        } else {
          return AppConstants.TRANSPARENT;
        }
      }));
}
