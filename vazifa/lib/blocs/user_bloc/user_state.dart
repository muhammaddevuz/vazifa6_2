import 'package:equatable/equatable.dart';

sealed class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final Map<String, dynamic> user;

  UserLoadedState({required this.user});
}

class UserErrorState extends UserState {
  final String error;
  UserErrorState({required this.error});
}
