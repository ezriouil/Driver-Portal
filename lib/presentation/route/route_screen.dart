import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/widgets/glass_circle_button.dart';
import '../../core/widgets/lottie_loading_wrapper.dart';
import 'route_controller.dart';
import 'trip_info_sheet.dart';

class RouteScreen extends GetView<RouteController> {
  const RouteScreen({super.key, required this.trip});

  final dynamic trip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
           GoogleMap(
                  initialCameraPosition: controller.initialCameraPosition,
                  onMapCreated: controller.onMapCreated,
                  markers: controller.markers,
                  polylines: controller.polylines,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 12,
            left: 16,
            child: GlassCircleButton(
              icon: Iconsax.arrow_left_2_copy,
              onTap: () => Get.back(),
            ),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 12,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GlassCircleButton(
                  icon: Iconsax.search_zoom_in_1_copy,
                  onTap: controller.zoomIn,
                ),
                const SizedBox(height: 8),
                GlassCircleButton(
                  icon: Iconsax.search_zoom_out_1_copy,
                  onTap: controller.zoomOut,
                ),
              ],
            ),
          ),
          TripInfoSheet(trip: controller.trip),
        ],
      ),
    );
  }
}
