import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_constants.dart';

/// Default border radius for bottom sheet.
const double _kSheetRadius = 24;

/// Styled bottom sheet helper using AppConstants and theme.
class AppBottomSheet {
  AppBottomSheet._();

  /// Shows a styled bottom sheet with [content].
  /// Uses theme-aware background and barrier, rounded top corners.
  static Future<T?> show<T>({
    required Widget content,
    bool canPop = true,
    bool enableDrag = true,
    bool isScrollControlled = true,
    bool isDismissible = true,
  }) async {
    final context = Get.context!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Get.bottomSheet<T>(
      PopScope(
        canPop: canPop,
        child: content,
      ),
      enableDrag: enableDrag,
      useRootNavigator: false,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      elevation: 0,
      exitBottomSheetDuration: const Duration(milliseconds: 500),
      barrierColor: AppConstants.BLACK.withValues(alpha: isDark ? 0.8 : 0.6),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: AppConstants.WHITE,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(_kSheetRadius)),
      ),
      backgroundColor: isDark ? AppConstants.BLACK : AppConstants.WHITE,
    );
  }
}
