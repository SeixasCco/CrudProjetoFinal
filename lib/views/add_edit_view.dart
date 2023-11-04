import 'package:flutter/material.dart';
import '../models/parking_spot.dart';
import '../bloc/parking_spot_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/consts.dart';

class ParkingSpotEditView extends StatefulWidget {
  final ParkingSpot? parkingSpot;

  ParkingSpotEditView({this.parkingSpot});

  @override
  _ParkingSpotEditViewState createState() => _ParkingSpotEditViewState();
}

class _ParkingSpotEditViewState extends State<ParkingSpotEditView> {
  final _formKey = GlobalKey<FormState>();
  late String licensePlate;
  late String model;
  late String color;

  @override
  void initState() {
    super.initState();
    licensePlate = widget.parkingSpot?.licensePlate ?? '';
    model = widget.parkingSpot?.model ?? '';
    color = widget.parkingSpot?.color ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.parkingSpot == null
            ? AppStrings.addParkingSpot
            : AppStrings.editParkingSpot),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                initialValue: licensePlate,
                decoration:
                    InputDecoration(labelText: AppStrings.licensePlateHint),
                onSaved: (value) => licensePlate = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.licensePlateValidationMessage;
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: model,
                decoration: InputDecoration(labelText: AppStrings.modelHint),
                onSaved: (value) => model = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.modelValidationMessage;
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: color,
                decoration: InputDecoration(labelText: AppStrings.colorHint),
                onSaved: (value) => color = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.colorValidationMessage;
                  }
                  return null;
                },
              ),
              ElevatedButton(
                child: Text(widget.parkingSpot == null
                    ? AppStrings.addButton
                    : AppStrings.saveButton),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final newParkingSpot = ParkingSpot(
                      id: widget.parkingSpot?.id,
                      licensePlate: licensePlate,
                      model: model,
                      color: color,
                      registrationDate: widget.parkingSpot?.registrationDate ??
                          DateTime.now(),
                    );

                    if (widget.parkingSpot == null) {
                      context
                          .read<ParkingSpotBloc>()
                          .add(AddParkingSpot(newParkingSpot));
                    } else {
                      context
                          .read<ParkingSpotBloc>()
                          .add(UpdateParkingSpot(newParkingSpot));
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppStrings.savingParkingSpot)),
                    );
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
