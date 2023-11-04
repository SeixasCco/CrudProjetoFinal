import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/parking_spot_bloc.dart';
import '../views/details_view.dart';
import '../views/add_edit_view.dart';
import '../views/error_view.dart';
import '../constants/consts.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ParkingSpotBloc parkingSpotBloc = context.read<ParkingSpotBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appBarTitle)),
      body: BlocBuilder<ParkingSpotBloc, ParkingSpotState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedState) {
            return RefreshIndicator(
              onRefresh: () async {
                parkingSpotBloc.add(LoadParkingSpots());
              },
              child: ListView.builder(
                itemCount: state.spots.length,
                itemBuilder: (context, index) {
                  final spot = state.spots[index];
                  return ListTile(
                    title: Text(spot.licensePlate ?? 'N/A'),
                    subtitle: Text('${spot.model} - ${spot.color}'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                ParkingSpotDetailsView(parkingSpot: spot)),
                      );
                    },
                  );
                },
              ),
            );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ParkingSpotEditView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
