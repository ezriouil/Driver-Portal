import 'dart:ui';

import 'package:flutter/material.dart';

import '../config/app_constants.dart';

/// Frosted-glass circle button. Used on map (back, zoom in/out).
class GlassCircleButton extends StatelessWidget {
  const GlassCircleButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 48,
    this.iconSize = 22,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (isDark ? AppConstants.GRAY_DARK : AppConstants.GRAY_LIGHT).withValues(alpha: isDark ? 0.5 : 0.1),
              border: Border.all(
                color: isDark ? AppConstants.GRAY_LIGHT.withValues(alpha: 0.15) : AppConstants.GRAY_DARK.withValues(alpha: 0.6),
                width: 0.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppConstants.BLACK.withValues(alpha: isDark ? 0.15 : 0.04),
                  blurRadius: 24,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: iconSize, color: isDark ? AppConstants.WHITE : AppConstants.GRAY_DARK),
          ),
        ),
      ),
    );
  }
}
