import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/parking_spot_bloc.dart';
import '../models/parking_spot.dart';
import '../views/add_edit_view.dart';
import '../constants/consts.dart';

class ParkingSpotDetailsView extends StatelessWidget {
  final ParkingSpot parkingSpot;

  const ParkingSpotDetailsView({super.key, required this.parkingSpot});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ParkingSpotBloc, ParkingSpotState>(
      listener: (context, state) {
        if (state is ParkingSpotOperationSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(AppStrings.parkingSpotDeletedSuccess)),
            );
          Navigator.of(context).pop();
        } else if (state is ParkingSpotOperationFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(AppStrings.parkingSpotDeletedFailure)),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.parkingSpotDetailsTitle),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ParkingSpotEditView(parkingSpot: parkingSpot),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                if (parkingSpot.id != null) {
                  context
                      .read<ParkingSpotBloc>()
                      .add(DeleteParkingSpot(parkingSpot.id!));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppStrings.parkingSpotNullID)),
                  );
                }
              },
            ),
          ],
        ),
        body: Card(
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    '${AppStrings.licensePlateLabel}${parkingSpot.licensePlate}',
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text('${AppStrings.modelLabel}${parkingSpot.model}',
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text('${AppStrings.colorLabel}${parkingSpot.color}',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
