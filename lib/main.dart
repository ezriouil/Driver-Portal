// Driver Portal UI – Flutter app for drivers (map, ride offers, route, settings).
// Entry point: locks portrait orientation, uses GetX for routing and theme.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation, SystemUiMode;
import 'package:get/get.dart';

import 'core/theme/theme_app.dart';
import 'core/theme/theme_controller.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Portrait only.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Full-screen: hide status bar and system nav bar.
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  Get.put(ThemeController());
  runApp(const DriverPortalApp());
}

/// Root widget. Theme reacts to [ThemeController] (light/dark from Settings).
class DriverPortalApp extends StatelessWidget {
  const DriverPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() => GetMaterialApp(
          title: 'Driver Portal',
          debugShowCheckedModeBanner: false,
          theme: ThemeApp.lightTheme,
          darkTheme: ThemeApp.darkTheme,
          themeMode: themeController.themeMode.value,
          initialRoute: AppRoutes.splash,
          getPages: AppPages.routes,
        ));
  }
}
