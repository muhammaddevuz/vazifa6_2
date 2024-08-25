import 'package:vazifa/data/model/user_model.dart';

class GroupModel {
  int id;
  String name;
  UserModel main_teacher;
  UserModel assistant_teacher;
  List<UserModel> students;

  GroupModel({
    required this.id,
    required this.name,
    required this.main_teacher,
    required this.assistant_teacher,
    List<UserModel>? students,
  }) : students = students ?? [];

  // Factory constructor for creating a GroupModel from a map
  factory GroupModel.fromMap(Map<String, dynamic> map) {
    List<UserModel> students = (map['students'] as List).map((student) {
      return UserModel.fromMap(student);
    }).toList();

    return GroupModel(
      id: map['id'],
      name: map['name'],
      main_teacher: UserModel.fromMap(map['main_teacher']),
      assistant_teacher: UserModel.fromMap(map['assistant_teacher']),
      students: students,
    );
  }
}