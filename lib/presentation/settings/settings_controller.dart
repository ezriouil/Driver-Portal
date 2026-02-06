import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/config/app_config.dart';
import '../../core/config/app_constants.dart';
import '../../core/theme/theme_controller.dart';

/// Settings state: fare config, theme toggle, units (optional). Persists units to SharedPreferences.
class SettingsController extends GetxController {
  final AppConfig config = AppConfig();

  static const String _kUnitsKey = 'UNITS';

  /// Current units: 'KM/M²' (metric) or 'MILES/FT²' (imperial).
  final RxString currentUnits = 'KM/M²'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUnits();
  }

  Future<void> _loadUnits() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(_kUnitsKey);
      if (saved != null && (saved == 'KM/M²' || saved == 'MILES/FT²')) {
        currentUnits.value = saved;
      }
    } catch (_) {}
  }

  Future<void> setUnits(String value) async {
    currentUnits.value = value;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kUnitsKey, value);
    } catch (_) {}
  }

  /// Placeholder display name and email (replace with auth when available).
  String get displayName => 'Driver';
  String get email => 'driver@example.com';

  /// Editable total earnings for profile chip (numeric part only).
  final RxString totalEarningsDisplay = '0.00'.obs;

  /// Total earnings string for display (numeric + currency).
  String get totalEarnings => '${totalEarningsDisplay.value}${AppConstants.currencySymbol}';

  void setTotalEarnings(String value) {
    final trimmed = value.trim();
    totalEarningsDisplay.value = trimmed.isEmpty ? '0.00' : trimmed;
    Get.showSnackbar(
      const GetSnackBar(
        message: 'Earnings updated',
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      ),
    );
  }

  ThemeController get themeController => Get.find<ThemeController>();

  void saveBaseFare(String value) {
    config.setBaseFare(
      value.trim().isEmpty ? AppConstants.defaultBaseFare : value.trim(),
    );
  }

  void savePerKmRate(String value) {
    config.setPerKmRate(
      value.trim().isEmpty ? AppConstants.defaultPerKmRate : value.trim(),
    );
  }

  void save() {
    Get.showSnackbar(
      const GetSnackBar(
        message: 'Settings saved',
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      ),
    );
  }

  void toggleTheme(bool isDark) {
    themeController.setTheme(isDark);
  }

  void signOut() {
    Get.back();
    Get.showSnackbar(
      const GetSnackBar(
        message: 'Signed out',
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      ),
    );
  }
}
