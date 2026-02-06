import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/config/app_constants.dart';
import '../../core/utils/app_bottom_sheet.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_text_field.dart';
import 'settings_controller.dart';
import 'settings_setting_tile.dart';

/// Spacing constants matching reference layout.
const double _kSpaceDefault = 8;
const double _kSpaceBetweenItems = 16;
const double _kSpaceBetweenSections = 24;

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  static bool _isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color _grayColor(BuildContext context) =>
      _isDark(context) ? AppConstants.GRAY_DARK : AppConstants.GRAY_LIGHT;

  static Color _darkLightColor(BuildContext context) =>
      _isDark(context) ? AppConstants.WHITE : AppConstants.GRAY_DARK;

  @override
  Widget build(BuildContext context) {
    final isDark = _isDark(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: Theme.of(context).textTheme.titleLarge),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2_copy, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: _kSpaceBetweenItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: _kSpaceDefault * 2),

              // Account Section
              Text(
                'Account',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: _darkLightColor(context),
                    ),
              ),
              const SizedBox(height: _kSpaceBetweenItems / 1.5),

              _SectionCard(
                isDark: isDark,
                grayColor: _grayColor(context),
                darkLightColor: _darkLightColor(context),
                children: [
                  SettingsSettingTile(
                    title: 'Base fare',
                    subTitle: 'Fixed amount at the start of each trip',
                    icon: Iconsax.money_recive_copy,
                    trailing: Icon(
                      Directionality.of(context) == TextDirection.rtl
                          ? Iconsax.arrow_left_2_copy
                          : Iconsax.arrow_right_3_copy,
                      color: _darkLightColor(context),
                    ),
                    onClick: () => _showFareSettingsSheet(context),
                  ),
                  Divider(height: 1, color: _grayColor(context)),
                  SettingsSettingTile(
                    title: 'Per km rate',
                    subTitle: 'Amount charged per kilometer driven',
                    icon: Iconsax.routing_2_copy,
                    trailing: Icon(
                      Directionality.of(context) == TextDirection.rtl
                          ? Iconsax.arrow_left_2_copy
                          : Iconsax.arrow_right_3_copy,
                      color: _darkLightColor(context),
                    ),
                    onClick: () => _showKmRateSheet(context),
                  ),
                ],
              ),

              const SizedBox(height: _kSpaceBetweenSections),

              // Preferences Section
              Text(
                'Preferences',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: _darkLightColor(context),
                    ),
              ),
              const SizedBox(height: _kSpaceBetweenItems / 1.5),

              _SectionCard(
                isDark: isDark,
                grayColor: _grayColor(context),
                darkLightColor: _darkLightColor(context),
                children: [
                Obx(() {
                    final isDark = controller.themeController.themeMode.value == ThemeMode.dark ||
                        (controller.themeController.themeMode.value == ThemeMode.system &&
                            WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark);
                    return SettingsSettingTile(
                      title: 'Dark mode',
                      subTitle: 'Use dark theme',
                      icon: Iconsax.colorfilter_copy,
                      trailing: Transform.scale(
                        scale: 0.75,
                        child: Switch(
                          value: isDark,
                          onChanged: controller.toggleTheme,
                          activeTrackColor: (isDark ? AppConstants.SECONDARY : AppConstants.PRIMARY).withValues(alpha: 0.5),
                          activeThumbColor: isDark ? AppConstants.SECONDARY : AppConstants.PRIMARY,
                        ),
                      ),
                      onClick: () => controller.toggleTheme(!isDark),
                    );
                  }),  
                ],
              ),

              const SizedBox(height: _kSpaceBetweenSections),

              // Version
              Center(
                child: Text(
                  'Version 1.0.0',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),

              const SizedBox(height: _kSpaceDefault * 4),
            ],
          ),
        ),
      ),
    );
  }

  void _showEarningsBottomSheet(BuildContext context) {
    final ctrl = Get.find<SettingsController>();
    final textController = TextEditingController(text: ctrl.totalEarningsDisplay.value);

    AppBottomSheet.show(
      content: Padding(
        padding: const EdgeInsets.all(_kSpaceBetweenItems),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total earnings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: _darkLightColor(context),
              ),
            ),
            const SizedBox(height: _kSpaceBetweenItems / 2),
            Text(
              'Update the total earnings shown on your profile.',
              style: Theme.of(context).textTheme.bodyMedium
            ),
            const SizedBox(height: _kSpaceBetweenItems),
            CustomTextField(
              controller: textController,
              hint: 'e.g. 0.00',
              icon: Iconsax.money_send_copy,
              prefixText: '${AppConstants.currencySymbol} ',
              prefixStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: _darkLightColor(context)),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: _kSpaceBetweenItems),
            CustomElevatedButton(
              onPressed: () {
                ctrl.setTotalEarnings(textController.text);
                Get.back();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _showFareSettingsSheet(BuildContext context) {
    final baseFareController = TextEditingController(text: controller.config.baseFare);
    final darkLight = _darkLightColor(context);

    AppBottomSheet.show(
      content: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(_kSpaceBetweenItems),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: _darkLightColor(context).withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
              Text(
                'Base fare',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: darkLight,
                ),
              ),
              const SizedBox(height: _kSpaceBetweenItems / 2),
              Text(
                'Fixed amount charged at the start of each trip.',
                style: Theme.of(context).textTheme.bodyMedium
              ),
              const SizedBox(height: _kSpaceBetweenItems * 1.2),
              CustomTextField(
                controller: baseFareController,
                hint: 'e.g. 5.00',
                icon: Iconsax.money_recive_copy,
                // prefixText: '${AppConstants.currencySymbol} ',
                // prefixStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: darkLight),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: _kSpaceBetweenItems * 1.2),
              CustomElevatedButton(
                height: 45,
                onPressed: () {
                  controller.saveBaseFare(baseFareController.text);
                  controller.save();
                  Get.back();
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showKmRateSheet(BuildContext context) {
    final perKmController = TextEditingController(text: controller.config.perKmRate);
    final darkLight = _darkLightColor(context);

    AppBottomSheet.show(
      content: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(_kSpaceBetweenItems),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: _darkLightColor(context).withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
              Text(
                'Per km rate',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: darkLight,
                ),
              ),
              const SizedBox(height: _kSpaceBetweenItems / 2),
              Text(
                'Amount charged per kilometer driven.',
                style: Theme.of(context).textTheme.bodyMedium
              ),
              const SizedBox(height: _kSpaceBetweenItems * 1.2),
              CustomTextField(
                controller: perKmController,
                hint: 'e.g. 2.50',
                icon: Iconsax.routing_2_copy,
                // prefixText: '${AppConstants.currencySymbol} ',
                // prefixStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: darkLight),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: _kSpaceBetweenItems * 1.2),
              CustomElevatedButton(
                height: 45,
                onPressed: () {
                  controller.savePerKmRate(perKmController.text);
                  controller.save();
                  Get.back();
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.isDark,
    required this.grayColor,
    required this.darkLightColor,
    required this.children,
  });

  final bool isDark;
  final Color grayColor;
  final Color darkLightColor;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_kSpaceBetweenItems * 1.2),
        color: isDark ? null : Colors.white,
        gradient: isDark
            ? const LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  AppConstants.GRAY_DARK,
                  AppConstants.BLACK,
                ],
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: isDark ? AppConstants.GRAY_DARK : AppConstants.GRAY_LIGHT,
            blurRadius: 1,
            blurStyle: BlurStyle.inner,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: kSettingsTileHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
