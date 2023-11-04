import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/parking_spot.dart';
import '../repositories/parking_spot_repository.dart';

// Eventos
abstract class ParkingSpotEvent {}

class LoadParkingSpots extends ParkingSpotEvent {}

class AddParkingSpot extends ParkingSpotEvent {
  final ParkingSpot parkingSpot;
  AddParkingSpot(this.parkingSpot);
}

class UpdateParkingSpot extends ParkingSpotEvent {
  final ParkingSpot parkingSpot;
  UpdateParkingSpot(this.parkingSpot);
}

class DeleteParkingSpot extends ParkingSpotEvent {
  final String id;
  DeleteParkingSpot(this.id);
}

class LoadingState extends ParkingSpotState {}

class LoadedState extends ParkingSpotState {
  final List<ParkingSpot> spots;
  LoadedState(this.spots);
}

class ErrorState extends ParkingSpotState {
  final String message;

  ErrorState(this.message);
}

// Estados
abstract class ParkingSpotState {}

class ParkingSpotInitialState extends ParkingSpotState {}

class ParkingSpotLoading extends ParkingSpotState {}

class ParkingSpotLoaded extends ParkingSpotState {
  final List<ParkingSpot> parkingSpots;
  ParkingSpotLoaded(this.parkingSpots);
}

class ParkingSpotOperationSuccess extends ParkingSpotState {}

class ParkingSpotOperationFailure extends ParkingSpotState {}

class ParkingSpotBloc extends Bloc<ParkingSpotEvent, ParkingSpotState> {
  final ParkingSpotRepository repository;

  ParkingSpotBloc(this.repository) : super(ParkingSpotInitialState()) {
    on<LoadParkingSpots>((event, emit) async {
      emit(ParkingSpotLoading());
      try {
        final spots = await repository.getParkingSpots();
        emit(ParkingSpotLoaded(spots));
      } catch (error) {
        emit(ParkingSpotOperationFailure());
      }
    });

    on<AddParkingSpot>((event, emit) async {
      try {
        await repository.addParkingSpot(event.parkingSpot);
        emit(ParkingSpotOperationSuccess());
        add(LoadParkingSpots());
      } catch (error) {
        emit(ParkingSpotOperationFailure());
      }
    });

    on<UpdateParkingSpot>((event, emit) async {
      if (event.parkingSpot.id != null) {
        try {
          await repository.updateParkingSpot(
              event.parkingSpot.id!, event.parkingSpot);
          emit(ParkingSpotOperationSuccess());
          add(LoadParkingSpots());
        } catch (error) {
          emit(ParkingSpotOperationFailure());
        }
      } else {
        emit(ParkingSpotOperationFailure());
      }
    });

    on<DeleteParkingSpot>((event, emit) async {
      try {
        await repository.deleteParkingSpot(event.id);
        emit(ParkingSpotOperationSuccess());
        add(LoadParkingSpots());
      } catch (error) {
        emit(ParkingSpotOperationFailure());
      }
    });
  }
}
