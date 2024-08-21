import 'package:equatable/equatable.dart';
import 'package:vazifa/data/model/group_model.dart';
import 'package:vazifa/data/model/user_model.dart';

sealed class GroupState extends Equatable {
  @override
  List<Object> get props => [];
}

class GroupInitialState extends GroupState {}

class GroupLoadingState extends GroupState {}

class GroupLoadedState extends GroupState {
  final List<GroupModel> groups;

  GroupLoadedState({required this.groups});
}

class GroupErrorState extends GroupState {
  final String error;
  GroupErrorState({required this.error});
}
