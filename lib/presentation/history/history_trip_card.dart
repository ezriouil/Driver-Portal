// Single trip card in history list: rider, route, "View Route" button.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/config/app_constants.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/routes/app_routes.dart';
import '../../domain/models/trip_entity.dart';

/// History list card styled like [RideOfferCard]: glass effect, header, route section, single action.
class HistoryTripCard extends StatelessWidget {
  const HistoryTripCard({super.key, required this.trip});

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

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                isDark ? AppConstants.GRAY_DARK : AppConstants.GRAY_LIGHT,
                isDark ? AppConstants.BLACK : AppConstants.WHITE,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: isDark ? AppConstants.GRAY_DARK : AppConstants.GRAY_LIGHT,
                blurRadius: 1,
                blurStyle: BlurStyle.inner,
                offset: const Offset(2, 2),
              ),
            ],
            border: Border.all(
              color: isDark ? AppConstants.GRAY_DARK.withValues(alpha: 0.15) : AppConstants.GRAY_DARK.withValues(alpha: 0.6),
              width: 0.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _CardHeader(
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
              _ViewRouteBar(
                accentColor: accentColor,
                onViewRoute: () => Get.toNamed(AppRoutes.route, arguments: trip),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({
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
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
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
                      color: accentColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Completed',
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
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
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

class _ViewRouteBar extends StatelessWidget {
  const _ViewRouteBar({
    required this.accentColor,
    required this.onViewRoute,
  });

  final Color accentColor;
  final VoidCallback onViewRoute;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: CustomElevatedButton(
        bgColor: accentColor,
        textColor: AppConstants.WHITE,
        elevation: 2,
        onPressed: onViewRoute,
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
              'View Route',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppConstants.WHITE,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Iconsax.arrow_right_2,
              size: 18,
              color: AppConstants.WHITE,
            ),
          ],
        ),
      ),
    );
  }
}
