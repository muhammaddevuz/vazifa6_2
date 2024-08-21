import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vazifa/blocs/user_bloc/user_event.dart';
import 'package:vazifa/blocs/user_bloc/user_state.dart';
import 'package:vazifa/services/user_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
    on<GetUserEvent>(_onGetUser);
  }

  Future<void> _onGetUser(GetUserEvent event, emit) async {
    emit(UserLoadingState());
    final prefs = await SharedPreferences.getInstance();
    final UserService userService = UserService();
    try {
      final String token = prefs.getString("token")!;
      print(token);
      final Map<String, dynamic> response = await userService.getUser(token);
      emit(UserLoadedState(user: response));
    } catch (e) {
      emit(UserErrorState(error: e.toString()));
    }
  }
}
