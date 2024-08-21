import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_event.dart';
import 'package:vazifa/ui/screens/role/admin_screen.dart';
import 'package:vazifa/ui/widget/custom_drawer_for_admin.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({super.key});

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController mainTeacherIdController = TextEditingController();
  TextEditingController asistantTeacherIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Group",
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
              controller: nameEditingController,
              decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            SizedBox(height: 15),
            TextField(
              keyboardType: TextInputType.number,
              controller: mainTeacherIdController,
              decoration: InputDecoration(
                  labelText: "Main Teacher Id",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            SizedBox(height: 15),
            TextField(
              keyboardType: TextInputType.number,
              controller: asistantTeacherIdController,
              decoration: InputDecoration(
                  labelText: "Asistant Teacher Id",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            SizedBox(height: 15),
            ElevatedButton(
                onPressed: ()  {
                   context.read<GroupBloc>().add(AddGroupEvent(
                      name: nameEditingController.text,
                      main_teacher_id: int.parse(mainTeacherIdController.text),
                      assistant_teacher_id:
                          int.parse(asistantTeacherIdController.text)));
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
