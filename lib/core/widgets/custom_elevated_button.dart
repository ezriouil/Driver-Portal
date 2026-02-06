import 'package:driver_portal_ui/core/config/app_constants.dart';
import 'package:flutter/material.dart';

/// Primary action button. Uses [AppConstants.PRIMARY] / [SECONDARY] by default.
class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.width,
    this.height,
    this.bgColor,
    this.textColor,
    this.side = BorderSide.none,
    this.elevation,
  });

  final double? width;
  final double? height;
  final double? elevation;
  final Color? bgColor;
  final Color? textColor;
  final BorderSide side;
  final GestureTapCallback onPressed;
  final Widget child;

  static const double _spaceDefault = 8;
  static const double _spaceBetweenItems = 16;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor = isDark ? AppConstants.SECONDARY : AppConstants.PRIMARY;
    final resolvedBg = bgColor ?? defaultColor;
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? _spaceDefault * 6,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: _spaceBetweenItems, vertical: _spaceBetweenItems / 4),
          backgroundColor: resolvedBg,
          foregroundColor: textColor ?? AppConstants.WHITE,
          elevation: elevation ?? 2,
          shadowColor: resolvedBg,
          side: side,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_spaceDefault * 2)),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
