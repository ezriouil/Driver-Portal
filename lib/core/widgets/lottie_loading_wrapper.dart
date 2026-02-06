import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../config/app_constants.dart';

/// Wraps [child] and shows a full-screen Lottie loading animation for [duration]
/// before revealing the content. Uses [assets/animations/loading_primary.json].
class LottieLoadingWrapper extends StatefulWidget {
  const LottieLoadingWrapper({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.assetPath = 'assets/animations/loading_primary.json',
  });

  final Widget child;
  final Duration duration;
  final String assetPath;

  @override
  State<LottieLoadingWrapper> createState() => _LottieLoadingWrapperState();
}

class _LottieLoadingWrapperState extends State<LottieLoadingWrapper> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.duration, () {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      final backgroundColor =
          isDark ? AppConstants.BLACK : AppConstants.GRAY_LIGHT;
      return Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Lottie.asset(
            widget.assetPath,
            fit: BoxFit.contain,
            repeat: true,
          ),
        ),
      );
    }
    return widget.child;
  }
}

/// Spacing between Lottie and title, and between title and subtitle.
const double _kSpaceBetweenItems = 16;
const double _kSpaceBetweenTitleSubtitle = 8;

/// Animation paths for light/dark.
const String _kLoadingPrimary = 'assets/animations/loading_primary.json';
const String _kLoadingSecondary = 'assets/animations/loading_secondary.json';

/// Shows the loading Lottie with optional title and subtitle, for use in place of the map.
class LottieMapLoading extends StatelessWidget {
  const LottieMapLoading({
    super.key,
    this.title = 'Loading map ...',
    this.subtitle = 'Preparing your view',
    this.showTitle = true,
    this.showSubtitle = true,
    this.color,
  });

  final String title;
  final String subtitle;
  final bool showTitle;
  final bool showSubtitle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? AppConstants.BLACK : AppConstants.GRAY_LIGHT;
    final textColor = color ?? (isDark ? AppConstants.WHITE : AppConstants.GRAY_DARK);
    final lottieAsset = isDark ? _kLoadingSecondary : _kLoadingPrimary;

    return Container(
      color: backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              lottieAsset,
              width: 80,
              height: 80,
              fit: BoxFit.contain,
              repeat: true,
            ),
            if (showTitle) ...[
              const SizedBox(height: _kSpaceBetweenItems),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: textColor,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
            if (showSubtitle) ...[
              const SizedBox(height: _kSpaceBetweenTitleSubtitle),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: textColor,
                    ),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
