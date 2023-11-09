import '../services/parking_spot_service.dart';
import '../models/parking_spot.dart';

class ParkingSpotRepository {
  final ParkingSpotService service;

  ParkingSpotRepository(this.service);

  Future<List<ParkingSpot>> getParkingSpots() => service.fetchParkingSpots();

  Future<ParkingSpot> addParkingSpot(ParkingSpot spot) =>
      service.createParkingSpot(spot);

  Future<ParkingSpot> updateParkingSpot(String id, ParkingSpot spot) =>
      service.updateParkingSpot(id, spot);

  Future<void> deleteParkingSpot(String id) => service.deleteParkingSpot(id);
}
