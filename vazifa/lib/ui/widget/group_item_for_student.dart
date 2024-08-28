import 'package:flutter/material.dart';
import 'package:vazifa/data/model/class_model.dart';
import 'package:vazifa/data/model/group_model.dart';
import 'package:vazifa/ui/screens/group_information_screen.dart';

class GroupItemForStudent extends StatefulWidget {
  final GroupModel groupModel;
  const GroupItemForStudent({super.key, required this.groupModel});

  @override
  State<GroupItemForStudent> createState() => _GroupItemForStudentState();
}

class _GroupItemForStudentState extends State<GroupItemForStudent> {
  @override
  void initState() {
    super.initState();
  }

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
                    groupModel: widget.groupModel,
                  ),
                ));
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.blue),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text(
                  "Group Name: ${widget.groupModel.name}",
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  "Main Teacher Id: ${widget.groupModel.mainTeacher.id}",
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  "Assistant Teacher Id: ${widget.groupModel.assistantTeacher.id}",
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                ExpansionTile(
                  title: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Timetable",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.schedule,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: widget.groupModel.classes.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          List<ClassModel> classes = widget.groupModel.classes;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                classes[index].dayName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  title: Text(classes[index].roomName),
                                  subtitle: Text(
                                    "${classes[index].startTime} - ${classes[index].endTime}",
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        // Timetable qismi uchun ExpansionTile
      ],
    );
  }
}
