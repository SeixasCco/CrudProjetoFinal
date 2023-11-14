import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/parking_spot_bloc.dart';
import '../views/details_view.dart';
import '../views/add_edit_view.dart';
import '../views/error_view.dart';
import '../constants/consts.dart';

class ParkingSpotDeleteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deletar Vaga'),
      ),
      body: BlocBuilder<ParkingSpotBloc, ParkingSpotState>(
        builder: (context, state) {
          if (state is ParkingSpotLoaded) {
            return ListView.builder(
              itemCount: state.parkingSpots.length,
              itemBuilder: (context, index) {
                final spot = state.parkingSpots[index];
                return ListTile(
                  title: Text(spot.licensePlate ?? 'N/A'),
                  subtitle: Text('${spot.model} - ${spot.color}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmar Exclusão'),
                            content: Text('Deseja excluir a vaga de "${spot.licensePlate}"?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancelar'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Dismiss the dialog
                                },
                              ),
                              TextButton(
                                child: const Text('Excluir'),
                                onPressed: () {
                                  BlocProvider.of<ParkingSpotBloc>(context).add(
                                    DeleteParkingSpot(spot.id!),
                                  );
                                  Navigator.of(context).pop(); // Dismiss the dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is ParkingSpotLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // Handle other states or return an empty Container/placeholder
            return const Center(
              child: Text('Nenhuma vaga disponível.'),
            );
          }
        },
      ),
    );
  }
}