import 'package:vazifa/data/model/Subject_model.dart';
import 'package:vazifa/data/model/class_model.dart';
import 'package:vazifa/data/model/user_model.dart';

class GroupModel {
  int id;
  String name;
  UserModel mainTeacher;
  UserModel assistantTeacher;
  SubjectModel? subjectModel;
  List<UserModel> students;
  List<ClassModel> classes;

  GroupModel({
    required this.id,
    required this.name,
    required this.mainTeacher,
    required this.assistantTeacher,
    required this.subjectModel,
    required this.students,
    required this.classes,
  });

  // Factory constructor for creating a GroupModel from a map
  factory GroupModel.fromMap(Map<String, dynamic> map) {
    List<UserModel> students = (map['students'] as List).map((student) {
      return UserModel.fromMap(student);
    }).toList();

    List<ClassModel> classes = (map['classes'] as List).map((clas) {
      return ClassModel.fromMap(clas);
    }).toList();

    return GroupModel(
      id: map['id'],
      name: map['name'],
      mainTeacher: UserModel.fromMap(map['main_teacher']),
      assistantTeacher: UserModel.fromMap(map['assistant_teacher']),
      students: students,
      classes: classes,
      subjectModel: map['subject'] != null
          ? SubjectModel.fromMap(map['subject'])
          : null, // If subject is null, subjectModel will be null
    );
  }
}
