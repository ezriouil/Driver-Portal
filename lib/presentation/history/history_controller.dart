import 'package:get/get.dart';

import '../../data/mock/mock_trips.dart';
import '../../domain/models/trip_entity.dart';

/// Provides [history] from mock data for the history list.
class HistoryController extends GetxController {
  List<TripEntity> get history => MockTrips.history;
}
