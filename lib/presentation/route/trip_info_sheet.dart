import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/config/app_constants.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_outlined_button.dart';
import '../../domain/models/trip_entity.dart';

class TripInfoSheet extends StatelessWidget {
  const TripInfoSheet({super.key, required this.trip});

  final TripEntity trip;

  static bool _isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    final isDark = _isDark(context);
    final textPrimary = isDark ? AppConstants.WHITE : AppConstants.BLACK;
    final textSecondary = isDark
        ? AppConstants.WHITE.withValues(alpha: 0.6)
        : AppConstants.GRAY_DARK;
    final accentColor = isDark ? AppConstants.SECONDARY : AppConstants.PRIMARY;

    return DraggableScrollableSheet(
      initialChildSize: 0.38,
      minChildSize: 0.2,
      maxChildSize: 0.55,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                color: (isDark ? AppConstants.GRAY_DARK : AppConstants.GRAY_LIGHT).withValues(alpha: isDark ? 0.5 : 0.1),
                border: Border.all(
                  color: isDark
                      ? AppConstants.GRAY_LIGHT.withValues(alpha: 0.15)
                      : AppConstants.GRAY_DARK.withValues(alpha: 0.6),
                  width: 0.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppConstants.BLACK.withValues(alpha: isDark ? 0.15 : 0.04),
                    blurRadius: 24,
                    offset: const Offset(0, -6),
                  ),
                ],
              ),
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: textSecondary.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _SheetHeader(
                    riderName: trip.riderName,
                    riderImagePath: trip.riderImagePath,
                    tripId: trip.id,
                    priceDisplay: trip.priceDisplay,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                    accentColor: accentColor,
                    isDark: isDark,
                  ),
                  _RouteSection(
                    pickupAddress: trip.pickupAddress,
                    destinationAddress: trip.destinationAddress,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                    accentColor: accentColor,
                  ),
                  _ActionBar(accentColor: accentColor),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SheetHeader extends StatelessWidget {
  const _SheetHeader({
    required this.riderName,
    this.riderImagePath,
    required this.tripId,
    required this.priceDisplay,
    required this.textPrimary,
    required this.textSecondary,
    required this.accentColor,
    required this.isDark,
  });

  final String riderName;
  final String? riderImagePath;
  final String tripId;
  final String priceDisplay;
  final Color textPrimary;
  final Color textSecondary;
  final Color accentColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isDark
                      ? textSecondary.withValues(alpha: 0.3)
                      : AppConstants.WHITE,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark ? textSecondary : AppConstants.WHITE,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppConstants.BLACK.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                child: riderImagePath != null
                    ? Image.asset(
                        riderImagePath!,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      )
                    : Text(
                        _initials(riderName),
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: textPrimary,
                          letterSpacing: 0.5,
                        ),
                      ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      riderName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Rider',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: textSecondary,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
              ),
              _CircleIconButton(
                icon: Iconsax.message,
                backgroundColor: isDark
                    ? textSecondary.withValues(alpha: 0.4)
                    : AppConstants.GRAY_DARK,
                onTap: () {},
              ),
              const SizedBox(width: 10),
              _CircleIconButton(
                icon: Iconsax.call,
                backgroundColor: accentColor,
                showAccentRing: true,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#${tripId.length > 10 ? tripId.substring(0, 10) : tripId}',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    priceDisplay,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: isDark ? AppConstants.WHITE : AppConstants.PRIMARY,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _formatDate(DateTime.now()),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: textSecondary,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((s) => s.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      final s = parts.first;
      return s.length >= 2 ? s.substring(0, 2).toUpperCase() : s.toUpperCase();
    }
    final a = parts.first.isNotEmpty ? parts.first[0] : '';
    final b = parts.last.isNotEmpty ? parts.last[0] : '';
    return '$a$b'.toUpperCase();
  }

  String _formatDate(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${d.day} ${months[d.month - 1]}, ${d.year}';
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.backgroundColor,
    required this.onTap,
    this.showAccentRing = false,
  });

  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onTap;
  final bool showAccentRing;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: showAccentRing
                ? AppConstants.YELLOW_LIGHT.withValues(alpha: 0.5)
                : AppConstants.TRANSPARENT,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppConstants.BLACK.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 20, color: AppConstants.WHITE),
      ),
    );
  }
}

class _RouteSection extends StatelessWidget {
  const _RouteSection({
    required this.pickupAddress,
    required this.destinationAddress,
    required this.textPrimary,
    required this.textSecondary,
    required this.accentColor,
  });

  final String pickupAddress;
  final String destinationAddress;
  final Color textPrimary;
  final Color textSecondary;
  final Color accentColor;

  static const double _leadingWidth = 14.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: _leadingWidth,
                child: Center(
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: textPrimary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pickup',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: textSecondary,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      pickupAddress,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: SizedBox(
              width: 2,
              height: 20,
              child: CustomPaint(
                painter: _DashedLinePainter(color: textSecondary),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: _leadingWidth,
                child: Center(
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: accentColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withValues(alpha: 0.4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deliver To',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: textSecondary,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      destinationAddress,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: textPrimary,
                            fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  _DashedLinePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.5)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashHeight = 4.0;
    const gapHeight = 4.0;
    var y = 0.0;

    while (y < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, y),
        Offset(size.width / 2, (y + dashHeight).clamp(0, size.height)),
        paint,
      );
      y += dashHeight + gapHeight;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({required this.accentColor});

  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: CustomOutlinedButton(
              color: context.isDarkMode ? AppConstants.GRAY_LIGHT : AppConstants.GRAY_DARK,
              elevation: 0,
              side: BorderSide(
                color: (context.isDarkMode ? AppConstants.GRAY_LIGHT : AppConstants.GRAY_DARK).withValues(alpha: 0.5),
                width: 0.5,
              ),
              onPressed: () => Get.back(),
              child: const Text('Cancel', maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: CustomElevatedButton(
              bgColor: accentColor,
              textColor: AppConstants.WHITE,
              elevation: 2,
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppConstants.WHITE.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Iconsax.location,
                      size: 16,
                      color: AppConstants.WHITE,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Navigate',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppConstants.WHITE,
                      fontSize: 14,
                    ), maxLines: 1, overflow: TextOverflow.ellipsis
                  ),
                  const SizedBox(width: 8),
                  const Icon(Iconsax.arrow_right_2, size: 18, color: AppConstants.WHITE),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
