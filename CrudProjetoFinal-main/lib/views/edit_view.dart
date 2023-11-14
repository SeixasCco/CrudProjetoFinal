import 'package:flutter/material.dart';
import '../models/parking_spot.dart';
import '../services/parking_spot_service.dart';

class ParkingSpotEditView extends StatefulWidget {
  @override
  _ParkingSpotEditViewState createState() => _ParkingSpotEditViewState();
}

class _ParkingSpotEditViewState extends State<ParkingSpotEditView> {
  late final ParkingSpotService _service;
  List<ParkingSpot> _parkingSpots = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _service = ParkingSpotService();
    _loadParkingSpots();
  }

  Future<void> _loadParkingSpots() async {
    try {
      List<ParkingSpot> spots = await _service.fetchParkingSpots();
      setState(() {
        _parkingSpots = spots;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falhou ao carregar as vagas: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Vaga'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _parkingSpots.length,
              itemBuilder: (context, index) {
                final spot = _parkingSpots[index];
                return ListTile(
                  title: Text(spot.licensePlate ?? 'N/A'),
                  subtitle: Text('${spot.model} - ${spot.color}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _confirmAndDeleteParkingSpot(spot.id!),
                  ),
                );
              },
            ),
    );
  }
}
