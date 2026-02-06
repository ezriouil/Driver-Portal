import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/config/app_constants.dart';
import 'history_controller.dart';
import 'history_trip_card.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = controller.history;

    return Scaffold(
      appBar: AppBar(
        title: Text('History', style: Theme.of(context).textTheme.titleMedium),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2_copy, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: history.isEmpty
          ? Center(
              child: Text(
                'No trips yet',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppConstants.GRAY_DARK,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: history.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final trip = history[index];
                return HistoryTripCard(trip: trip);
              },
            ),
    );
  }
}
