// Ride offer card: rider, pickup/destination, price, Accept/Decline. Shown when online.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/config/app_constants.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_outlined_button.dart';
import '../../domain/models/trip_entity.dart';
import 'home_controller.dart';

class RideOfferCard extends StatelessWidget {
  const RideOfferCard({
    super.key,
    required this.trip,
  });

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
    final homeCtrl = Get.find<HomeController>();

    final accentYellow = isDark ? AppConstants.SECONDARY : AppConstants.PRIMARY;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: (isDark ? AppConstants.GRAY_DARK : AppConstants.GRAY_LIGHT).withValues(alpha: isDark ? 0.5 : 0.1),
            border: Border.all(
              color: isDark
                  ? (isDark ? AppConstants.GRAY_LIGHT : AppConstants.GRAY_DARK).withValues(alpha: 0.15)
                  : (isDark ? AppConstants.GRAY_LIGHT : AppConstants.GRAY_DARK).withValues(alpha: 0.6),
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
                accentYellow: accentYellow,
                isDark: isDark,
              ),
              _RouteSection(
                pickupAddress: trip.pickupAddress,
                destinationAddress: trip.destinationAddress,
                textPrimary: textPrimary,
                textSecondary: textSecondary,
                accentYellow: accentYellow,
              ),
              _ActionBar(
                onDecline: () {},
                onAccept: () => homeCtrl.acceptRide(trip),
                accentYellow: accentYellow,
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
    required this.accentYellow,
    required this.isDark,
  });

  final String riderName;
  final String? riderImagePath;
  final String tripId;
  final String priceDisplay;
  final Color textPrimary;
  final Color textSecondary;
  final Color accentYellow;
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
              // Avatar - image or initials, using AppConstants colors
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
              // Circular chat button (dark) and call button (yellow)
              _CircleIconButton(
                icon: Iconsax.message,
                backgroundColor: isDark
                    ? textSecondary.withValues(alpha: 0.4)
                    : AppConstants.GRAY_DARK,
                accentColor: accentYellow,
                showAccentRing: false,
                onTap: () {},
              ),
              const SizedBox(width: 10),
              _CircleIconButton(
                icon: Iconsax.call,
                backgroundColor: accentYellow,
                accentColor: accentYellow,
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
    required this.accentColor,
    this.showAccentRing = false,
  });

  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onTap;
  final Color accentColor;
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
                ? accentColor.withValues(alpha: 0.5)
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
    required this.accentYellow,
  });

  final String pickupAddress;
  final String destinationAddress;
  final Color textPrimary;
  final Color textSecondary;
  final Color accentYellow;

  static const double _leadingWidth = 14.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Pickup — dot centered left
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
          // Dashed line between rows (centered under dots)
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
          // Row 2: Deliver To — dot centered left
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
                      color: accentYellow,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: accentYellow.withValues(alpha: 0.4),
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
  const _ActionBar({
    required this.onDecline,
    required this.onAccept,
    required this.accentYellow,
  });

  final VoidCallback onDecline;
  final VoidCallback onAccept;
  final Color accentYellow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Row(
        children: [
          Expanded(
            child: CustomOutlinedButton(
              color: (context.isDarkMode ? AppConstants.GRAY_LIGHT : AppConstants.GRAY_DARK),
              elevation: 0,
              side: BorderSide(
                color: (context.isDarkMode ? AppConstants.GRAY_LIGHT : AppConstants.GRAY_DARK).withValues(alpha: 0.5),
                width: 0.5,
              ),
              onPressed: onDecline,
              child: const Text('Decline', maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: CustomElevatedButton(
              bgColor: accentYellow,
              textColor: AppConstants.WHITE,
              elevation: 2,
              onPressed: onAccept,
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
                    'Accept Ride',
                    
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
