import 'package:driver_portal_ui/core/config/app_constants.dart';
import 'package:flutter/material.dart';

class CustomInputTheme {
  CustomInputTheme._();

  /// Text Field For Light Theme
  static InputDecorationTheme lightInputTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppConstants.GRAY_DARK,
    suffixIconColor: AppConstants.GRAY_DARK,
    
    labelStyle: const TextStyle().copyWith(
        fontSize: 11.0,
        color: AppConstants.GRAY_DARK,
        fontFamily: "Open_sans_regular"),
    errorStyle: const TextStyle().copyWith(
        fontSize: 10.0,
        fontStyle: FontStyle.normal,
        color: AppConstants.RED_LIGHT,
        fontFamily: "Open_sans_regular"),
    hintStyle: const TextStyle().copyWith(
        fontSize: 9.0,
        color: AppConstants.GRAY_LIGHT,
        fontFamily: "Open_sans_regular"),
    floatingLabelStyle: const TextStyle()
        .copyWith(color: AppConstants.BLACK.withValues(alpha: 0.8)),
    border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(16.0),
        borderSide:
            BorderSide(color: AppConstants.GRAY_DARK.withValues(alpha: 0.2))),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(16.0),
        borderSide:
            BorderSide(color: AppConstants.GRAY_DARK.withValues(alpha: 0.2))),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(16.0),
        borderSide:
            BorderSide(color: AppConstants.BLACK.withValues(alpha: 0.8))),
    errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: AppConstants.RED_LIGHT)),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(16.0),
      borderSide:
          BorderSide(color: AppConstants.RED_LIGHT.withValues(alpha: 0.5)),
    ),
  );

  /// Text Field For Dark Theme
  static InputDecorationTheme darkInputTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppConstants.GRAY_LIGHT,
    suffixIconColor: AppConstants.GRAY_LIGHT,
    labelStyle: const TextStyle().copyWith(
        fontSize: 11.0,
        color: AppConstants.GRAY_LIGHT,
        fontFamily: "Open_sans_regular"),
    errorStyle: const TextStyle().copyWith(
        fontSize: 10.0,
        fontStyle: FontStyle.normal,
        color: AppConstants.RED_LIGHT,
        fontFamily: "Open_sans_regular"),
    hintStyle: const TextStyle().copyWith(
        fontSize: 9.0,
        color: AppConstants.GRAY_DARK,
        fontFamily: "Open_sans_regular"),
    floatingLabelStyle: const TextStyle()
        .copyWith(color: AppConstants.WHITE.withValues(alpha: 0.9)),
    border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(16.0),
        borderSide:
            BorderSide(color: AppConstants.GRAY_LIGHT.withValues(alpha: 0.2))),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(16.0),
        borderSide:
            BorderSide(color: AppConstants.GRAY_LIGHT.withValues(alpha: 0.2))),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: AppConstants.WHITE)),
    errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: AppConstants.RED_LIGHT)),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(16.0),
        borderSide:
            BorderSide(color: AppConstants.RED_LIGHT.withValues(alpha: 0.5))),
  );
}
