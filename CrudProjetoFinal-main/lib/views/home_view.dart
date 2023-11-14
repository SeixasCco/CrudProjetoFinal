import 'package:crudprojetofinal/views/edit_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/parking_spot_bloc.dart';
import '../views/details_view.dart';
import '../views/add_view.dart';
import '../views/error_view.dart';
import '../constants/consts.dart';
import '../views/delete_view.dart';
import '../views/edit_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ParkingSpotBloc parkingSpotBloc = context.read<ParkingSpotBloc>();

    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appBarTitle),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                parkingSpotBloc.add(LoadParkingSpots());
              },
            ),
          ],
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
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ParkingSpotDetailsView(parkingSpot: spot),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is ParkingSpotLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ErrorState) {
              return ErrorView(
                message: state.message,
                onRetry: () {
                  parkingSpotBloc.add(LoadParkingSpots());
                },
              );
            } else {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    parkingSpotBloc.add(LoadParkingSpots());
                  },
                  child: const Text(AppStrings.loadParkingButtonText),
                ),
              );
            }
          },
        ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              final ParkingSpotBloc parkingSpotBloc = BlocProvider.of<ParkingSpotBloc>(context);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return BlocProvider.value(
                    value: parkingSpotBloc,
                    child: ParkingSpotDeleteView(),
                  );
                }),
              );
            },
            child: const Icon(Icons.delete),
            heroTag: 'delete',
          ),
          SizedBox(height: 8), // Spacing between the buttons
          FloatingActionButton(
            onPressed: () {
              final ParkingSpotBloc parkingSpotBloc = BlocProvider.of<ParkingSpotBloc>(context);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return BlocProvider.value(
                    value: parkingSpotBloc,
                    child: ParkingSpotAddView.ParkingSpitAddView(),
                  );
                }),
              );
            },
            child: const Icon(Icons.add),
            heroTag: 'add',
          ),
          SizedBox(height: 8), // Spacing between the buttons
          FloatingActionButton(
            onPressed: () {
              final ParkingSpotBloc parkingSpotBloc = BlocProvider.of<ParkingSpotBloc>(context);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return BlocProvider.value(
                    value: parkingSpotBloc,
                    child: ParkingSpotEditView(),
                  );
                }),
              );
            },
            child: const Icon(Icons.edit),
            heroTag: 'edit',
          ),
        ],
      ),
        );
  }
}
