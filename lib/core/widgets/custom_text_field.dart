import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/app_constants.dart';

const double _kSpaceBetweenItems = 16;

/// Styled text field with optional icon, prefix, and validation. Used in Settings sheets.
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.icon,
    this.prefixText,
    this.prefixStyle,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.enabled = true,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.onChanged,
    this.obscureText = false,
    this.readOnly = false,
    this.validator,
    this.trailing,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String hint;
  final IconData? icon;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final Widget? trailing;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool enabled;
  final bool obscureText;
  final bool readOnly;
  final int? maxLength;
  final int minLines;
  final int maxLines;
  final void Function(String)? onChanged;
  final String? Function(String? value)? validator;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;

  static bool _isDark(BuildContext context) => Theme.of(context).brightness == Brightness.dark;
  static Color _grayColor(BuildContext context) => _isDark(context) ? AppConstants.GRAY_DARK : AppConstants.GRAY_LIGHT;
  static Color _darkLightColor(BuildContext context) => _isDark(context) ? AppConstants.WHITE : AppConstants.GRAY_DARK;

  @override
  Widget build(BuildContext context) {
    final gray = _grayColor(context);
    final darkLight = _darkLightColor(context);

    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      textInputAction: textInputAction,
      cursorColor: darkLight,
      cursorOpacityAnimates: true,
      cursorRadius: const Radius.circular(_kSpaceBetweenItems),
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: gray),
        contentPadding: EdgeInsets.all(_kSpaceBetweenItems / (icon == null ? 1 : 2)),
        prefixIcon: icon != null ? Icon(icon, color: darkLight, size: 16.0) : null,
        prefixText: prefixText,
        prefixStyle: prefixStyle ?? Theme.of(context).textTheme.bodyMedium?.copyWith(color: darkLight),
        suffixIcon: trailing,
        counterStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 8),
      ),
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      enabled: enabled,
      readOnly: readOnly,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      autocorrect: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
