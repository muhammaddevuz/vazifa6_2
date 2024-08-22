import 'package:vazifa/data/model/user_model.dart';

class GroupModel {
  int id;
  String name;
  UserModel main_teacher;
  UserModel assistant_teacher;
  List students;

  GroupModel({
    required this.id,
    required this.name,
    required this.main_teacher,
    required this.assistant_teacher,
    List? students,
  }): this.students = students ?? [];
}
