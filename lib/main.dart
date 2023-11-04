import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'views/home_view.dart';
import 'bloc/parking_spot_bloc.dart';
import 'repositories/parking_spot_repository.dart';
import 'services/parking_spot_service.dart';
import 'constants/consts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appBarTitle,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => ParkingSpotBloc(
          ParkingSpotRepository(ParkingSpotService()),
        ),
        child: HomeView(),
      ),
    );
  }
}
