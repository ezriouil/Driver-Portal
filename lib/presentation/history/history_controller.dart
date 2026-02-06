import 'package:get/get.dart';

import '../../data/mock/mock_trips.dart';
import '../../domain/models/trip_entity.dart';

class HistoryController extends GetxController {
  List<TripEntity> get history => MockTrips.history;
}
