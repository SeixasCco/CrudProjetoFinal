import 'package:flutter/material.dart';
import '../models/parking_spot.dart';
import '../services/parking_spot_service.dart';

class ParkingSpotDeleteView extends StatefulWidget {
  @override
  _ParkingSpotDeleteViewState createState() => _ParkingSpotDeleteViewState();
}

class _ParkingSpotDeleteViewState extends State<ParkingSpotDeleteView> {
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

  Future<void> _confirmAndDeleteParkingSpot(String id) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: const Text('Deseja excluir esta vaga?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (shouldDelete ?? false) {
      final String deleteEndpoint = 'https://parking-spot-238adbfb7467.herokuapp.com/parking-spot/$id';
      print('Sending DELETE request to: $deleteEndpoint');

      try {
        await _service.deleteParkingSpot(id);
        print('Delete request successful.');
        _loadParkingSpots();
      } catch (e) {
        print('Delete request failed: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha ao excluir: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deletar Vaga'),
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
              icon: const Icon(Icons.delete),
              onPressed: () => _confirmAndDeleteParkingSpot(spot.id!),
            ),
          );
        },
      ),
    );
  }
}
