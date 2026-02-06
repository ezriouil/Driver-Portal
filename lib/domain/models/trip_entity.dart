/// Single ride/trip. Pure Dart; used by mock data, home offer card, route screen, history.
class TripEntity {
  const TripEntity({
    required this.id,
    required this.riderName,
    required this.pickupAddress,
    required this.destinationAddress,
    required this.pickupLat,
    required this.pickupLng,
    required this.destinationLat,
    required this.destinationLng,
    required this.priceDisplay,
    this.routePoints = const [],
    this.riderImagePath,
  });

  final String id;
  final String riderName;
  final String? riderImagePath;
  final String pickupAddress;
  final String destinationAddress;
  final double pickupLat;
  final double pickupLng;
  final double destinationLat;
  final double destinationLng;
  final String priceDisplay;
  final List<LatLngPoint> routePoints;
}

/// Lat/lng point for route polyline.
class LatLngPoint {
  const LatLngPoint({required this.lat, required this.lng});
  final double lat;
  final double lng;
}
