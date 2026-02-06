import 'package:driver_portal_ui/core/config/app_constants.dart';
import 'package:flutter/material.dart';


class CustomDatePickerTheme {
  CustomDatePickerTheme._();

  /// Date Picker For Light Theme
  static DatePickerThemeData lightDatePickerTheme = DatePickerThemeData(

    backgroundColor: AppConstants.WHITE,
    surfaceTintColor: AppConstants.TRANSPARENT,
    headerForegroundColor: AppConstants.BLACK,

    yearBackgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) { return AppConstants.PRIMARY; }
      return AppConstants.TRANSPARENT;
    }),
    yearForegroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) { return AppConstants.WHITE; }
      return AppConstants.BLACK;
    }),
    dayBackgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) { return AppConstants.PRIMARY; }
      return AppConstants.TRANSPARENT;
    }),
    dayForegroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) { return AppConstants.WHITE; }
      return AppConstants.BLACK;
    }),

    todayBackgroundColor: WidgetStateProperty.all(AppConstants.PRIMARY),
    todayForegroundColor: WidgetStateProperty.all(AppConstants.WHITE),
    cancelButtonStyle: ButtonStyle(foregroundColor: WidgetStateProperty.all(AppConstants.BLACK), backgroundColor: WidgetStateProperty.all(AppConstants.TRANSPARENT)),
    confirmButtonStyle: ButtonStyle(foregroundColor: WidgetStateProperty.all(AppConstants.BLACK), backgroundColor: WidgetStateProperty.all(AppConstants.TRANSPARENT)),
  );

  /// Date Picker For Dark Theme
  static DatePickerThemeData darkDatePickerTheme = DatePickerThemeData(

    backgroundColor: AppConstants.GRAY_DARK,
    surfaceTintColor: AppConstants.TRANSPARENT,
    headerForegroundColor: AppConstants.WHITE,

    yearBackgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) { return AppConstants.SECONDARY; }
      return AppConstants.TRANSPARENT;
    }),
    yearForegroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) { return AppConstants.BLACK; }
      return AppConstants.WHITE;
    }),
    dayBackgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) { return AppConstants.SECONDARY; }
      return AppConstants.TRANSPARENT;
    }),
    dayForegroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) { return AppConstants.BLACK; }
      return AppConstants.WHITE;
    }),

    todayBackgroundColor: WidgetStateProperty.all(AppConstants.SECONDARY),
    todayForegroundColor: WidgetStateProperty.all(AppConstants.BLACK),
    cancelButtonStyle: ButtonStyle(foregroundColor: WidgetStateProperty.all(AppConstants.WHITE), backgroundColor: WidgetStateProperty.all(AppConstants.TRANSPARENT)),
    confirmButtonStyle: ButtonStyle(foregroundColor: WidgetStateProperty.all(AppConstants.WHITE), backgroundColor: WidgetStateProperty.all(AppConstants.TRANSPARENT)),
  );

}
