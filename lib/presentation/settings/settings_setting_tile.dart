import 'package:flutter/material.dart';

import '../../core/config/app_constants.dart';

/// Spacing used in settings layout.
const double _kSpaceBetweenItems = 16;

/// Fixed height so all tiles are the same size across sections.
const double kSettingsTileHeight = 68;

/// A single row tile: leading icon, title + subtitle column, optional trailing.
/// All tiles use [kSettingsTileHeight] so Account and Preferences sections match.
class SettingsSettingTile extends StatelessWidget {
  const SettingsSettingTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.onClick,
    this.trailing,
    this.color,
  });

  final String title;
  final String subTitle;
  final IconData icon;
  final VoidCallback? onClick;
  final Widget? trailing;
  final Color? color;

  static bool _isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color _darkLightColor(BuildContext context) =>
      _isDark(context) ? AppConstants.WHITE : AppConstants.GRAY_DARK;

  @override
  Widget build(BuildContext context) {
    final resolvedColor = color ?? _darkLightColor(context);

    return InkWell(
      onTap: onClick,
      overlayColor: WidgetStateProperty.all(AppConstants.TRANSPARENT),
      child: SizedBox(
        height: kSettingsTileHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: _kSpaceBetweenItems),
          child: Row(
            children: [
              Icon(
                icon,
                size: 26,
                color: resolvedColor,
              ),
              const SizedBox(width: _kSpaceBetweenItems),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: resolvedColor,
                        fontFamily: 'Open_sans_bold'
                      ),
                    ),
                    const SizedBox(height: _kSpaceBetweenItems / 4),
                    Text(
                      subTitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: resolvedColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: _kSpaceBetweenItems / 2),
                SizedBox(
                  height: 40,
                  child: Center(child: trailing),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
