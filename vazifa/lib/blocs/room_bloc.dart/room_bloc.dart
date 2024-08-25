import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/room_bloc.dart/room_event.dart';
import 'package:vazifa/blocs/room_bloc.dart/room_state.dart';
import 'package:vazifa/data/model/room_model.dart';
import 'package:vazifa/data/services/room_service.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc() : super(RoomInitialState()) {
    on<GetRoomsEvent>(_onGetRooms);
    on<GetAvailableRoomsEvent>(_onGetAvailableRooms);
    on<AddRoomEvent>(_addRoom);
    on<UpdateRoomEvent>(_updateRoom);
    on<DeleteRoomEvent>(_deleteRoom);
  }

  Future<void> _onGetRooms(GetRoomsEvent event, emit) async {
    emit(RoomLoadingState());
    final RoomService roomService = RoomService();
    try {
      final response = await roomService.getRooms();
      List<RoomModel> rooms = [];

      response['data'].forEach((value) {
        rooms.add(RoomModel.fromMap(value));
      });

      emit(RoomLoadedState(rooms: rooms));
    } catch (e) {
      emit(RoomErrorState(error: e.toString()));
    }
  }

  Future<void> _onGetAvailableRooms(GetAvailableRoomsEvent event, emit) async {
    emit(RoomLoadingState());
    final RoomService roomService = RoomService();
    try {
      final response = await roomService.getAvailableRooms(
          event.day_id, event.start_time, event.end_time);
      List<RoomModel> rooms = [];

      response['data'].forEach((value) {
        rooms.add(RoomModel.fromMap(value));
      });

      emit(RoomLoadedState(rooms: rooms));
    } catch (e) {
      emit(RoomErrorState(error: e.toString()));
    }
  }

  Future<void> _addRoom(AddRoomEvent event, emit) async {
    final RoomService roomService = RoomService();
    try {
      await roomService.addRoom(event.name, event.description, event.capacity);
      add(GetRoomsEvent());
    } catch (e) {
      emit(RoomErrorState(error: e.toString()));
    }
  }

  Future<void> _updateRoom(UpdateRoomEvent event, emit) async {
    final RoomService roomService = RoomService();
    try {
      await roomService.updateRoom(
          event.roomId, event.name, event.description, event.capacity);
      add(GetRoomsEvent());
    } catch (e) {
      emit(RoomErrorState(error: e.toString()));
    }
  }

  Future<void> _deleteRoom(DeleteRoomEvent event, emit) async {
    final RoomService roomService = RoomService();
    try {
      await roomService.deleteRoom(event.roomId);
      add(GetRoomsEvent());
    } catch (e) {
      emit(RoomErrorState(error: e.toString()));
    }
  }
}
