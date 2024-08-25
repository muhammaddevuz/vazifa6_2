import 'package:flutter/material.dart';
import 'package:vazifa/data/model/group_model.dart';
import 'package:vazifa/ui/screens/group_information_screen.dart';

class GroupItemForStudent extends StatelessWidget {
  final GroupModel groupModel;
  const GroupItemForStudent({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroupInformationScreen(
                    groupModel: groupModel,
                  ),
                ));
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.blue),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Group Name: ${groupModel.name}",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  "Main Teacher Id: ${groupModel.main_teacher.id}",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  "Asistant Teacher id: ${groupModel.assistant_teacher.id}",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
