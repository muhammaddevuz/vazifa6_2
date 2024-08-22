import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/users_bloc/users_bloc.dart';
import 'package:vazifa/blocs/users_bloc/users_event.dart';
import 'package:vazifa/data/model/group_model.dart';

class StudentGroupInformation extends StatefulWidget {
  final GroupModel groupModel;
  const StudentGroupInformation({super.key, required this.groupModel});

  @override
  State<StudentGroupInformation> createState() =>
      _GroupInformationScreenState();
}

class _GroupInformationScreenState extends State<StudentGroupInformation> {
  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(GetUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          centerTitle: true,
          title: Text(
            widget.groupModel.name,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Teachers",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              ListTile(
                title: Text(
                  widget.groupModel.main_teacher.name,
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(widget.groupModel.main_teacher.phone),
                leading: Container(
                  width: 80,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                  clipBehavior: Clip.hardEdge,
                  child: widget.groupModel.main_teacher.photo == null
                      ? Icon(
                          Icons.person,
                          size: 50,
                        )
                      : Image.network(
                          "http://millima.flutterwithakmaljon.uz/storage/avatars/${widget.groupModel.main_teacher.photo}"),
                ),
              ),
              ListTile(
                title: Text(
                  widget.groupModel.assistant_teacher.name,
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(widget.groupModel.assistant_teacher.phone),
                leading: Container(
                  width: 80,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                  clipBehavior: Clip.hardEdge,
                  child: widget.groupModel.assistant_teacher.photo == null
                      ? Icon(
                          Icons.person,
                          size: 50,
                        )
                      : Image.network(
                          "http://millima.flutterwithakmaljon.uz/storage/avatars/${widget.groupModel.assistant_teacher.photo}"),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
