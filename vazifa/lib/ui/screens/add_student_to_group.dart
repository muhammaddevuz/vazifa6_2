import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_event.dart';
import 'package:vazifa/data/model/group_model.dart';
import 'package:vazifa/ui/screens/role/admin_screen.dart';
import 'package:vazifa/ui/widget/custom_drawer_for_admin.dart';

class AddStudentToGroup extends StatefulWidget {
  final GroupModel groupModel;
  const AddStudentToGroup({super.key, required this.groupModel});

  @override
  State<AddStudentToGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddStudentToGroup> {
  TextEditingController studentsIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Student To Group",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
      drawer: CustomDrawerForAdmin(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 15),
            TextField(
              keyboardType: TextInputType.number,
              controller: studentsIdController,
              decoration: InputDecoration(
                  labelText: "Students Id(1,2,6)",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  List students = [];
                  widget.groupModel.students.forEach(
                    (element) {
                      students.add(element['id']);
                    },
                  );
                  students.addAll(studentsIdController.text
                      .split(",")
                      .map(int.parse)
                      .toList());
                  print(students);
                  context.read<GroupBloc>().add(AddStudentsToGroupEvent(
                      groupId: widget.groupModel.id, studentsId: students));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminScreen(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10)),
                child: Text(
                  "Add Group",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
