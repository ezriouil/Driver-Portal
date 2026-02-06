import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/config/app_constants.dart';
import '../../core/config/map_style.dart';
import '../../core/routes/app_routes.dart';
import '../../data/mock/mock_trips.dart';
import '../../domain/models/trip_entity.dart';

class HomeController extends GetxController {
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(AppConstants.defaultLat, AppConstants.defaultLng),
    zoom: AppConstants.defaultZoom,
  );

  final RxInt currentIndex = 0.obs;
  final RxBool isOnline = false.obs;
  final RxBool mapLoading = true.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      if (mapLoading.value) mapLoading.value = false;
    });
  }

  void onMapCreated(GoogleMapController controller) {
    if (!mapController.isCompleted) {
      mapController.complete(controller);
    }
    controller.setMapStyle(mapStyleUber);
  }

  Future<void> zoomIn() async {
    final c = await mapController.future;
    final zoom = await c.getZoomLevel();
    final bounds = await c.getVisibleRegion();
    final center = LatLng(
      (bounds.southwest.latitude + bounds.northeast.latitude) / 2,
      (bounds.southwest.longitude + bounds.northeast.longitude) / 2,
    );
    await c.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: center,
          zoom: (zoom + 1).clamp(2.0, 21.0),
        ),
      ),
    );
  }

  Future<void> zoomOut() async {
    final c = await mapController.future;
    final zoom = await c.getZoomLevel();
    final bounds = await c.getVisibleRegion();
    final center = LatLng(
      (bounds.southwest.latitude + bounds.northeast.latitude) / 2,
      (bounds.southwest.longitude + bounds.northeast.longitude) / 2,
    );
    await c.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: center,
          zoom: (zoom - 1).clamp(2.0, 21.0),
        ),
      ),
    );
  }

  void setIndex(int index) {
    if (index == 1) {
      openDrawer();
      return;
    }
    if (index == 2) {
      goToHistory();
      return;
    }
    currentIndex.value = index;
  }

  void onBackTap() {
    Get.back();
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void toggleOnline() {
    isOnline.value = !isOnline.value;
    final isOn = isOnline.value;
    final bgColor = isOn ? AppConstants.GREEN_DARK : AppConstants.RED_DARK;
    final textTheme = Theme.of(Get.context!).textTheme;
    Get.snackbar(
      isOn ? 'Online' : 'Offline',
      isOn
          ? 'You are now available for ride requests'
          : 'You are no longer available for ride requests',
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
      backgroundColor: bgColor.withValues(alpha: 0.95),
      overlayBlur: 2,
      icon: Icon(
        isOn ? Iconsax.eye_copy : Iconsax.eye_slash_copy,
        color: AppConstants.WHITE,
        size: 24,
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      titleText: Text(
        isOn ? 'Online' : 'Offline',
        style: textTheme.titleMedium?.copyWith(
          color: AppConstants.WHITE,
          fontWeight: FontWeight.w600,
        ),
      ),
      messageText: Text(
        isOn
            ? 'You are now available for ride requests'
            : 'You are no longer available for ride requests',
        style: textTheme.bodySmall?.copyWith(
          color: AppConstants.WHITE.withValues(alpha: 0.95),
        ),
      ),
    );
  }

  void goToSettings() {
    Get.back();
    Get.toNamed(AppRoutes.settings);
  }

  void goToHistory() {
    Get.back();
    Get.toNamed(AppRoutes.history);
  }

  void acceptRide(TripEntity trip) {
    Get.toNamed(AppRoutes.route, arguments: trip);
  }

  TripEntity get nextOffer => MockTrips.nextOffer;
}
