import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_event.dart';
import 'package:vazifa/blocs/group_bloc/group_state.dart';
import 'package:vazifa/data/model/group_model.dart';
import 'package:vazifa/data/model/user_model.dart';
import 'package:vazifa/data/services/group_service.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(GroupInitialState()) {
    on<GetGroupsEvent>(_onGetGroups);
    on<GetStudentGroupsEvent>(_onGetStudentGroups);
    on<AddGroupEvent>(_addGroups);
    on<UpdateGroupEvent>(_updateGroups);
    on<AddStudentsToGroupEvent>(_addStudentsToGroups);
  }

  Future<void> _onGetGroups(GetGroupsEvent event, emit) async {
    emit(GroupLoadingState());
    final GroupService groupService = GroupService();
    try {
      final response = await groupService.getGroups();
      List<GroupModel> groups = [];

      response['data'].forEach(
        (value) {
          groups.add(
            GroupModel(
              id: value['id'],
              name: value['name'],
              main_teacher: UserModel(
                  id: value['main_teacher']['id'],
                  name: value['main_teacher']['name'],
                  email: value['main_teacher']['email'],
                  phone: value['main_teacher']['phone'],
                  photo: value['main_teacher']['photo'],
                  role: value['main_teacher']['role_id']),
              assistant_teacher: UserModel(
                  id: value['assistant_teacher']['id'],
                  name: value['assistant_teacher']['name'],
                  email: value['assistant_teacher']['email'],
                  phone: value['assistant_teacher']['phone'],
                  photo: value['assistant_teacher']['photo'],
                  role: value['assistant_teacher']['role_id']),
              students: value['students'],
            ),
          );
        },
      );
      emit(GroupLoadedState(groups: groups));
    } catch (e) {
      emit(GroupErrorState(error: e.toString()));
    }
  }
  Future<void> _onGetStudentGroups(GetStudentGroupsEvent event, emit) async {
    emit(GroupLoadingState());
    final GroupService groupService = GroupService();
    try {
      final response = await groupService.getStudentGroups();
      List<GroupModel> groups = [];

      response['data'].forEach(
        (value) {
          groups.add(
            GroupModel(
              id: value['id'],
              name: value['name'],
              main_teacher: UserModel(
                  id: value['main_teacher']['id'],
                  name: value['main_teacher']['name'],
                  email: value['main_teacher']['email'],
                  phone: value['main_teacher']['phone'],
                  photo: value['main_teacher']['photo'],
                  role: value['main_teacher']['role_id']),
              assistant_teacher: UserModel(
                  id: value['assistant_teacher']['id'],
                  name: value['assistant_teacher']['name'],
                  email: value['assistant_teacher']['email'],
                  phone: value['assistant_teacher']['phone'],
                  photo: value['assistant_teacher']['photo'],
                  role: value['assistant_teacher']['role_id']),
              students: value['students'],
            ),
          );
        },
      );
      emit(GroupLoadedState(groups: groups));
    } catch (e) {
      emit(GroupErrorState(error: e.toString()));
    }
  }

  Future<void> _addGroups(AddGroupEvent event, emit) async {
    final GroupService groupService = GroupService();
    try {
      await groupService.addGroup(
          event.name, event.main_teacher_id, event.assistant_teacher_id);
      add(GetGroupsEvent());
    } catch (e) {
      emit(GroupErrorState(error: e.toString()));
    }
  }

  Future<void> _addStudentsToGroups(AddStudentsToGroupEvent event, emit) async {
    final GroupService groupService = GroupService();
    try {
      await groupService.addStudentsToGroup(event.groupId, event.studentsId);
      add(GetGroupsEvent());
    } catch (e) {
      emit(GroupErrorState(error: e.toString()));
    }
  }

  Future<void> _updateGroups(UpdateGroupEvent event, emit) async {
    final GroupService groupService = GroupService();
    try {
      await groupService.updateGroup(event.groupId, event.name,
          event.main_teacher_id, event.assistant_teacher_id);
      add(GetGroupsEvent());
    } catch (e) {
      emit(GroupErrorState(error: e.toString()));
    }
  }
}
