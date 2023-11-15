import 'package:flutter/material.dart';
import '../models/parking_spot.dart';
import '../services/parking_spot_service.dart';
import '../constants/consts.dart';

class ParkingSpotAddView extends StatefulWidget {
  final ParkingSpot? parkingSpot;

  ParkingSpotAddView({super.key, this.parkingSpot});

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
  final ParkingSpotService _parkingSpotService = ParkingSpotService();

  bool get isEditing => widget.parkingSpot != null;

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

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final parkingSpot = ParkingSpot(
        id: isEditing ? widget.parkingSpot!.id : null,
        parkingSpotNumber: parkingSpotNumber,
        licensePlate: licensePlate,
        brandCar: brandCar,
        model: model,
        color: color,
        responsibleName: responsibleName,
        apartment: apartment,
        block: block,
      );

      print('Submitting parking spot with data: ${parkingSpot.toJson()}');

      try {
        if (isEditing) {
          print('Attempting to update parking spot with id: ${parkingSpot.id}');
          await _parkingSpotService.updateParkingSpot(parkingSpot.id!, parkingSpot);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Vaga atualizada com sucesso!')),
          );
        } else {
          print('Attempting to create a new parking spot.');
          await _parkingSpotService.createParkingSpot(parkingSpot);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Vaga adicionada com sucesso!')),
          );
        }
        Navigator.of(context).pop();
      } catch (e) {
        print('Failed to save parking spot: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar a vaga: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Vaga' : 'Adicionar Vaga'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  initialValue: parkingSpotNumber,
                  decoration: const InputDecoration(labelText: 'Número da vaga'),
                  onSaved: (value) => parkingSpotNumber = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor digite o número da vaga.';
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
                  decoration: const InputDecoration(labelText: 'Nome do Responsável'),
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
                      return 'Por favor digite o número do apartamento.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: block,
                  decoration: const InputDecoration(labelText: 'Bloco'),
                  onSaved: (value) => block = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor digite o bloco.';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  child: Text(isEditing ? 'Salvar Vaga' : 'Adicionar Vaga'),
                  onPressed: _submitForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
