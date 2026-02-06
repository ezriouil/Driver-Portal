import 'package:flutter/foundation.dart';

import 'app_constants.dart';

/// Runtime config (fixed logic, but values feel adjustable via Settings).
/// Not persisted in this demo; can add SharedPreferences later.
class AppConfig extends ChangeNotifier {
  AppConfig() {
    _baseFare = AppConstants.defaultBaseFare;
    _perKmRate = AppConstants.defaultPerKmRate;
  }

  late String _baseFare;
  late String _perKmRate;

  String get baseFare => _baseFare;
  String get perKmRate => _perKmRate;

  String get formattedBaseFare =>
      '${AppConstants.currencySymbol}$_baseFare';

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
