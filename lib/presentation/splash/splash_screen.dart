import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/config/app_constants.dart';
import '../../core/routes/app_routes.dart';

/// Shows app logo for 2 seconds then navigates to home.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Get.offAllNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: 120,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Icon(
            Icons.directions_car_rounded,
            size: 80,
            color:AppConstants.GRAY_DARK,
          ),
        ),
      ),
    );
  }
}
