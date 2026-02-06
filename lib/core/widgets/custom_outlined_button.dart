import 'package:driver_portal_ui/core/config/app_constants.dart';
import 'package:flutter/material.dart';

/// Secondary action button (outline). Theme-aware border and text color.
class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.side,
    this.width,
    this.height,
    this.color,
    this.elevation,
  });

  final double? width;
  final double? height;
  final double? elevation;
  final Color? color;
  final BorderSide? side;
  final GestureTapCallback onPressed;
  final Widget child;

  static const double _spaceDefault = 8;
  static const double _spaceBetweenItems = 16;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor = isDark ? AppConstants.SECONDARY : AppConstants.PRIMARY;
    final resolvedColor = color ?? defaultColor;
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? _spaceDefault * 6,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: _spaceBetweenItems, vertical: _spaceBetweenItems / 4),
          elevation: elevation ?? 2,
          backgroundColor: AppConstants.TRANSPARENT,
          foregroundColor: resolvedColor,
          shadowColor: resolvedColor,
          side: side ?? BorderSide(color: resolvedColor, width: 0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_spaceDefault * 2)),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
