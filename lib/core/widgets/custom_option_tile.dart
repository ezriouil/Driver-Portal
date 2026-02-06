import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../config/app_constants.dart';

/// Spacing (equivalent to CustomSizes.SPACE_BETWEEN_ITEMS).
const double _kSpaceBetweenItems = 16;

/// Option tile: leading icon/image in styled container, optional title, trailing icon or widget.
/// Mirrors CustomOptionTile API; uses AppConstants for colors.
class CustomOptionTile extends StatelessWidget {
  const CustomOptionTile({
    super.key,
    this.icon,
    this.imgUri,
    this.trailing = Iconsax.arrow_right_3_copy,
    this.trailingWidget,
    this.title,
    this.titleStyle,
    this.onPressed,
    this.color,
    this.imgColor,
  });

  final IconData? icon;
  final String? imgUri;
  final IconData trailing;
  final Widget? trailingWidget;
  final String? title;
  final TextStyle? titleStyle;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? imgColor;

  static bool _isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color _primaryColor(BuildContext context) =>
      _isDark(context) ? AppConstants.SECONDARY : AppConstants.PRIMARY;

  static Color _grayColor(BuildContext context) =>
      _isDark(context) ? AppConstants.GRAY_DARK : AppConstants.GRAY_LIGHT;

  @override
  Widget build(BuildContext context) {
    final primary = color ?? _primaryColor(context);
    final gray = _grayColor(context);

    return InkWell(
      onTap: onPressed,
      overlayColor: WidgetStateProperty.all<Color?>(AppConstants.TRANSPARENT),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: _kSpaceBetweenItems / 2),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(_kSpaceBetweenItems / 3),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.1),
                border: Border.all(color: primary),
                borderRadius: BorderRadius.circular(_kSpaceBetweenItems / 2),
              ),
              child: icon == null
                  ? (imgUri != null && imgUri!.isNotEmpty)
                      ? Image.asset(
                          imgUri!,
                          height: 15,
                          width: 15,
                          color: imgColor,
                        )
                      : const SizedBox(height: 15, width: 15)
                  : Icon(icon, color: primary, size: 15),
            ),
            if (title != null) ...[
              const SizedBox(width: _kSpaceBetweenItems),
              Expanded(
                child: Text(
                  title!,
                  style: titleStyle ??
                      Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: color ?? _primaryColor(context),
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
            trailingWidget ?? Icon(trailing, color: gray, size: 20),
          ],
        ),
      ),
    );
  }
}
