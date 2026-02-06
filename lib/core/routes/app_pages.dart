import 'package:get/get.dart';

import '../../presentation/splash/splash_screen.dart';
import '../../presentation/home/home_screen.dart';
import '../../presentation/home/home_controller.dart';
import '../../presentation/route/route_screen.dart';
import '../../presentation/route/route_controller.dart';
import '../../presentation/settings/settings_screen.dart';
import '../../presentation/settings/settings_controller.dart';
import '../../presentation/history/history_screen.dart';
import '../../presentation/history/history_controller.dart';

import 'app_routes.dart';

/// GetX bindings: lazy-put controllers when a route is opened.
class HomeBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<HomeController>(() => HomeController());
}

class RouteBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<RouteController>(() => RouteController());
}

class SettingsBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<SettingsController>(() => SettingsController());
}

class HistoryBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<HistoryController>(() => HistoryController());
}

/// All GetX routes. Route screen receives [Get.arguments] as [TripEntity].
class AppPages {
  AppPages._();

  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.home, page: () => const HomeScreen(), binding: HomeBinding()),
    GetPage(name: AppRoutes.route, page: () => RouteScreen(trip: Get.arguments), binding: RouteBinding()),
    GetPage(name: AppRoutes.settings, page: () => const SettingsScreen(), binding: SettingsBinding()),
    GetPage(name: AppRoutes.history, page: () => const HistoryScreen(), binding: HistoryBinding()),
  ];
}
