import 'package:flutter/foundation.dart';

import 'app_constants.dart';

/// Runtime config for base fare and per-km rate.
/// Values are editable from Settings; can be persisted later (e.g. SharedPreferences).
class AppConfig extends ChangeNotifier {
  AppConfig() {
    _baseFare = AppConstants.defaultBaseFare;
    _perKmRate = AppConstants.defaultPerKmRate;
  }

  late String _baseFare;
  late String _perKmRate;

  String get baseFare => _baseFare;
  String get perKmRate => _perKmRate;

  String get formattedBaseFare => '${AppConstants.currencySymbol}$_baseFare';

  void setBaseFare(String value) {
    _baseFare = value;
    notifyListeners();
  }

  void setPerKmRate(String value) {
    _perKmRate = value;
    notifyListeners();
  }

  void reset() {
    _baseFare = AppConstants.defaultBaseFare;
    _perKmRate = AppConstants.defaultPerKmRate;
    notifyListeners();
  }
}
