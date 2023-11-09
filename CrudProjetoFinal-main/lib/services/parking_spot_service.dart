import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/parking_spot.dart';
import '../constants/consts.dart';

class ParkingSpotService {
  Future<List<ParkingSpot>> fetchParkingSpots() async {
    final response = await http.get(Uri.parse('${AppStrings.baseURL}/list'));
    if (response.statusCode == 200) {
      List<dynamic> spotsJson = json.decode(response.body);
      return spotsJson.map((json) => ParkingSpot.fromJson(json)).toList();
    } else {
      throw Exception(AppStrings.loadParkingSpotsFailure);
    }
  }

  Future<ParkingSpot> createParkingSpot(ParkingSpot spot) async {
    final response = await http.post(
      Uri.parse('${AppStrings.baseURL}/create'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(spot.toJson()),
    );
    if (response.statusCode == 201) {
      return ParkingSpot.fromJson(json.decode(response.body));
    } else {
      throw Exception(AppStrings.createParkingSpotFailure);
    }
  }

  Future<ParkingSpot> updateParkingSpot(String id, ParkingSpot spot) async {
    final response = await http.put(
      Uri.parse('${AppStrings.baseURL}/update/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(spot.toJson()),
    );
    if (response.statusCode == 200) {
      return ParkingSpot.fromJson(json.decode(response.body));
    } else {
      throw Exception(AppStrings.updateParkingSpotFailure);
    }
  }

  Future<void> deleteParkingSpot(String id) async {
    final response = await http.delete(
      Uri.parse('${AppStrings.baseURL}/delete/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception(AppStrings.deleteParkingSpotFailure);
    }
  }
}
