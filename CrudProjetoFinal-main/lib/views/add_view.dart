import 'package:flutter/material.dart';
import '../models/parking_spot.dart';
import '../bloc/parking_spot_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/consts.dart';

class ParkingSpotAddView extends StatefulWidget {
  final ParkingSpot? parkingSpot;

  ParkingSpotAddView.ParkingSpitAddView({super.key, this.parkingSpot});

  @override
  _ParkingSpotAddViewState createState() => _ParkingSpotAddViewState();
}

class _ParkingSpotAddViewState extends State<ParkingSpotAddView> {
  final _formKey = GlobalKey<FormState>();
  late String licensePlate;
  late String model;
  late String color;
  late String parkingSpotNumber;
  late String brandCar;
  late String responsibleName;
  late String apartment;
  late String block;

  @override
  void initState() {
    super.initState();

    parkingSpotNumber = widget.parkingSpot?.parkingSpotNumber ?? '';
    licensePlate = widget.parkingSpot?.licensePlate ?? '';
    brandCar = widget.parkingSpot?.brandCar ?? '';
    model = widget.parkingSpot?.model ?? '';
    color = widget.parkingSpot?.color ?? '';
    responsibleName = widget.parkingSpot?.responsibleName ?? '';
    apartment = widget.parkingSpot?.apartment ?? '';
    block = widget.parkingSpot?.block ?? '';
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
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  initialValue: parkingSpotNumber,
                  decoration:
                  const InputDecoration(labelText: 'Numero da vaga'),
                  onSaved: (value) => parkingSpotNumber = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor digite o numero da vaga.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: licensePlate,
                  decoration: const InputDecoration(labelText: 'Placa'),
                  onSaved: (value) => licensePlate = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor digite a placa.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: brandCar,
                  decoration: const InputDecoration(labelText: 'Marca'),
                  onSaved: (value) => brandCar = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor digite a marca do carro.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: model,
                  decoration: const InputDecoration(labelText: 'Modelo'),
                  onSaved: (value) => model = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor digite o modelo do carro.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: color,
                  decoration: const InputDecoration(labelText: 'Cor'),
                  onSaved: (value) => color = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor digite a cor do carro.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: responsibleName,
                  decoration:
                  const InputDecoration(labelText: 'Nome do Responsável'),
                  onSaved: (value) => responsibleName = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor digite o nome do responsável.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: apartment,
                  decoration: const InputDecoration(labelText: 'Apartamento'),
                  onSaved: (value) => apartment = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor digite o numero do apartamento.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: block,
                  decoration: const InputDecoration(labelText: 'Block'),
                  onSaved: (value) => block = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor digite o bloco.';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  child: Text(widget.parkingSpot == null
                      ? 'Adicionar Vaga'
                      : 'Salvar Vaga'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      final newParkingSpot = ParkingSpot(
                        parkingSpotNumber: parkingSpotNumber,
                        licensePlate: licensePlate,
                        brandCar: brandCar,
                        model: model,
                        color: color,
                        responsibleName: responsibleName,
                        apartment: apartment,
                        block: block,
                      );

                      if (widget.parkingSpot == null) {
                        BlocProvider.of<ParkingSpotBloc>(context)
                            .add(AddParkingSpot(newParkingSpot));
                      } else {
                        BlocProvider.of<ParkingSpotBloc>(context)
                            .add(UpdateParkingSpot(newParkingSpot));
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Salvando Vaga...')),
                      );

                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
