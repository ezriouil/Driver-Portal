import '../../domain/models/trip_entity.dart';

/// Mock ride offer and history. Replace with API later.
class MockTrips {
  MockTrips._();

  static const double _pickupLat = 34.0209;
  static const double _pickupLng = -6.8416;
  static const double _destLat = 34.0181;
  static const double _destLng = -6.8326;

  static List<LatLngPoint> get _routePoints => [
        const LatLngPoint(lat: _pickupLat, lng: _pickupLng),
        const LatLngPoint(lat: 34.0195, lng: -6.8371),
        const LatLngPoint(lat: _destLat, lng: _destLng),
      ];

  static TripEntity get nextOffer => TripEntity(
        id: 'offer_01',
        riderName: 'Ezriouil',
        riderImagePath: 'assets/images/mohamed_ezriouil_1.png',
        pickupAddress: 'Avenue Mohammed V, Agdal, Rabat',
        destinationAddress: 'Hassan Tower, Rabat',
        pickupLat: _pickupLat,
        pickupLng: _pickupLng,
        destinationLat: _destLat,
        destinationLng: _destLng,
        priceDisplay: '45 MAD',
        routePoints: _routePoints,
      );

  static List<TripEntity> get history => [
        TripEntity(
          id: 'offer_02',
          riderName: 'Nabil Ezriouil',
          riderImagePath: 'assets/images/mohamed_ezriouil_1.png',
          pickupAddress: 'Avenue Fal Ould Oumeir, Rabat',
          destinationAddress: 'Medina, Rabat',
          pickupLat: 34.0150,
          pickupLng: -6.8320,
          destinationLat: 34.0280,
          destinationLng: -6.8380,
          priceDisplay: '28 MAD',
        ),
        TripEntity(
          id: 'offer_03',
          riderName: 'Miloud Ezriouil',
          riderImagePath: 'assets/images/mohamed_ezriouil_1.png',
          pickupAddress: 'Souissi, Rabat',
          destinationAddress: 'Quartier Hay Riad, Rabat',
          pickupLat: 34.0050,
          pickupLng: -6.8250,
          destinationLat: 34.0100,
          destinationLng: -6.8500,
          priceDisplay: '55 MAD',
        ),
      ];
}
