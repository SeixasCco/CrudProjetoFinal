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
    final uri = Uri.parse('${AppStrings.baseURL}/save');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(spot.toJson());

    try {
      final response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        return ParkingSpot.fromJson(json.decode(response.body));
      } else {
        throw Exception('Falhou ao criar uma vaga: ${response.body}');
      }
    } catch (e) {
      throw Exception('Falhou ao fazer POST: $e');
    }
  }

  Future<ParkingSpot> updateParkingSpot(String id, ParkingSpot spot) async {
    final String url = "https://parking-spot-238adfbb7467.herokuapp.com/parking-spot/"+id;
    final uri = Uri.parse(url);
    final response = await http.put(
      Uri.parse(url),
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
    final String url = "https://parking-spot-238adfbb7467.herokuapp.com/parking-spot/"+id;
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    if (response.statusCode != 200) {
      throw Exception('Falhou ao deletar vaga');
    }
  }
}
