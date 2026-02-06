import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/config/app_constants.dart';
import '../../domain/models/trip_entity.dart';

/// Route screen state: map controller, markers, polyline from [trip]. Fits bounds on load.
class RouteController extends GetxController {
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  TripEntity get trip => Get.arguments as TripEntity;

  Set<Marker> get markers {
    return {
      Marker(
        markerId: const MarkerId('pickup'),
        position: LatLng(trip.pickupLat, trip.pickupLng),
        icon: BitmapDescriptor.defaultMarkerWithHue(Get.context!.isDarkMode ? BitmapDescriptor.hueBlue : BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: 'Pickup', snippet: trip.pickupAddress),
        zIndexInt: 1,
      ),
      Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(trip.destinationLat, trip.destinationLng),
        icon: BitmapDescriptor.defaultMarkerWithHue(Get.context!.isDarkMode ? BitmapDescriptor.hueBlue : BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: 'Destination', snippet: trip.destinationAddress),
        zIndexInt: 2,
      ),
    };
  }

  Set<Polyline> get polylines {
    if (trip.routePoints.length < 2) return {};
    final points = trip.routePoints.map((p) => LatLng(p.lat, p.lng)).toList();
    final isDark = Get.context != null &&
        Theme.of(Get.context!).brightness == Brightness.dark;
    final routeColor = isDark ? AppConstants.SECONDARY : AppConstants.PRIMARY;
    return {
      Polyline(
        polylineId: const PolylineId('route'),
        points: points,
        color: routeColor,
        width: 4,
        geodesic: true,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        jointType: JointType.round,
      ),
    };
  }

  CameraPosition get initialCameraPosition => CameraPosition(
        target: LatLng(trip.pickupLat, trip.pickupLng),
        zoom: 14.5,
      );

  void onMapCreated(GoogleMapController controller) {
    if (!mapController.isCompleted) mapController.complete(controller);
    _fitBounds(controller);
  }

  Future<void> _fitBounds(GoogleMapController c) async {
    if (trip.routePoints.isEmpty) return;
    double minLat = trip.routePoints.first.lat;
    double maxLat = minLat;
    double minLng = trip.routePoints.first.lng;
    double maxLng = minLng;
    for (final p in trip.routePoints) {
      if (p.lat < minLat) minLat = p.lat;
      if (p.lat > maxLat) maxLat = p.lat;
      if (p.lng < minLng) minLng = p.lng;
      if (p.lng > maxLng) maxLng = p.lng;
    }
    await c.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat - 0.005, minLng - 0.005),
          northeast: LatLng(maxLat + 0.005, maxLng + 0.005),
        ),
        80,
      ),
    );
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
}
