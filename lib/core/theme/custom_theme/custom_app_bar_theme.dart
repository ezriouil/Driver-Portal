import 'package:driver_portal_ui/core/config/app_constants.dart' show AppConstants;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBarTheme {
  CustomAppBarTheme._();

  /// App Bar For Light Theme
  static AppBarTheme lightAppBarTheme = const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0.0,
      backgroundColor: AppConstants.TRANSPARENT,
      surfaceTintColor: AppConstants.TRANSPARENT,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppConstants.WHITE,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppConstants.WHITE,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: AppConstants.WHITE
      ),
      iconTheme: IconThemeData(color: AppConstants.BLACK, size: 24),
      actionsIconTheme: IconThemeData(color: AppConstants.BLACK, size: 24),
      titleTextStyle: TextStyle(
          fontSize: 18.0, fontFamily: "Open_sans_regular",
          fontWeight: FontWeight.w600,
          color: AppConstants.BLACK));

  /// App Bar For Dark Theme
  static AppBarTheme darkAppBarTheme = const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0.0,
      backgroundColor: AppConstants.TRANSPARENT,
      surfaceTintColor: AppConstants.TRANSPARENT,
      iconTheme: IconThemeData(color: AppConstants.WHITE, size: 24),
      actionsIconTheme: IconThemeData(color: AppConstants.WHITE, size: 24),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppConstants.BLACK,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: AppConstants.BLACK,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarDividerColor: AppConstants.BLACK
      ),
      titleTextStyle: TextStyle(
          fontSize: 18.0, fontFamily: "Open_sans_regular",
          fontWeight: FontWeight.w600,
          color: AppConstants.WHITE));
}
