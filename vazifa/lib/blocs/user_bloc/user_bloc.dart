import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/user_bloc/user_event.dart';
import 'package:vazifa/blocs/user_bloc/user_state.dart';
import 'package:vazifa/data/model/user_model.dart';
import 'package:vazifa/data/services/user_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
    on<GetUserEvent>(_onGetUser);
    on<UpdateUserEvent>(_updateUser);
  }

  Future<void> _onGetUser(GetUserEvent event, emit) async {
    emit(UserLoadingState());
    final UserService userService = UserService();
    try {
      final Map<String, dynamic> response = await userService.getUser();
      UserModel userModel = UserModel(
          id: response['data']['id'],
          name: response['data']['name'],
          email: response['data']['email'],
          phone: response['data']['phone'],
          photo: response['data']['photo'],
          role: response['data']['role_id']);
      emit(UserLoadedState(user: userModel));
    } catch (e) {
      emit(UserErrorState(error: e.toString()));
    }
  }


  Future<void> _updateUser(UpdateUserEvent event, emit) async {
    emit(UserLoadingState());
    final UserService userService = UserService();
    try {
      await userService.updateProfile(
          name: event.name,
          email: event.email,
          phone: event.phone,
          photo: event.phote);
      add(GetUserEvent());
    } catch (e) {
      emit(UserErrorState(error: e.toString()));
    }
  }
}
