import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/users_bloc/users_bloc.dart';
import 'package:vazifa/blocs/users_bloc/users_event.dart';
import 'package:vazifa/data/model/group_model.dart';

class GroupInformationScreen extends StatefulWidget {
  final GroupModel groupModel;
  const GroupInformationScreen({super.key, required this.groupModel});

  @override
  State<GroupInformationScreen> createState() => _GroupInformationScreenState();
}

class _GroupInformationScreenState extends State<GroupInformationScreen> {
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
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.groupModel.subjectModel != null)
                      Text(
                        "Subject: ${widget.groupModel.subjectModel!.name}",
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    const Text(
                      "Teachers",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  widget.groupModel.mainTeacher.name,
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: Text(widget.groupModel.mainTeacher.phone!),
                leading: Container(
                  width: 80,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey),
                  clipBehavior: Clip.hardEdge,
                  child: widget.groupModel.mainTeacher.photo == null
                      ? const Icon(
                          Icons.person,
                          size: 50,
                        )
                      : Image.network(
                          "http://millima.flutterwithakmaljon.uz/storage/avatars/${widget.groupModel.mainTeacher.photo}"),
                ),
              ),
              ListTile(
                title: Text(
                  widget.groupModel.assistantTeacher.name,
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: Text(widget.groupModel.assistantTeacher.phone!),
                leading: Container(
                  width: 80,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey),
                  clipBehavior: Clip.hardEdge,
                  child: widget.groupModel.assistantTeacher.photo == null
                      ? const Icon(
                          Icons.person,
                          size: 50,
                        )
                      : Image.network(
                          "http://millima.flutterwithakmaljon.uz/storage/avatars/${widget.groupModel.assistantTeacher.photo}"),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Students",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              itemCount: widget.groupModel.students.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    widget.groupModel.students[index].name,
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(widget.groupModel.students[index].phone ??
                      "raqam mavjud emas"),
                  leading: Container(
                    width: 80,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                    clipBehavior: Clip.hardEdge,
                    child: widget.groupModel.students[index].photo == null
                        ? const Icon(
                            Icons.person,
                            size: 50,
                          )
                        : Image.network(
                            "http://millima.flutterwithakmaljon.uz/storage/avatars/${widget.groupModel.students[index].photo}"),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ));
  }
}
