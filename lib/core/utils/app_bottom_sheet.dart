import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_constants.dart';

const double _kSheetRadius = 24;

/// Shows a styled bottom sheet (rounded top, theme-aware background).
/// Used by Settings for fare/km rate dialogs.
class AppBottomSheet {
  AppBottomSheet._();

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
      PopScope(canPop: canPop, child: content),
      enableDrag: enableDrag,
      useRootNavigator: false,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      elevation: 0,
      exitBottomSheetDuration: const Duration(milliseconds: 500),
      barrierColor: AppConstants.BLACK.withValues(alpha: isDark ? 0.8 : 0.6),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppConstants.WHITE, strokeAlign: BorderSide.strokeAlignOutside),
        borderRadius: const BorderRadius.all(Radius.circular(_kSheetRadius)),
      ),
      backgroundColor: isDark ? AppConstants.BLACK : AppConstants.WHITE,
    );
  }
}
