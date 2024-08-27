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
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text(
                  "Group Name: ${widget.groupModel.name}",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  "Main Teacher Id: ${widget.groupModel.main_teacher.id}",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  "Assistant Teacher Id: ${widget.groupModel.assistant_teacher.id}",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                ExpansionTile(
                  title: Row(
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
                        padding: EdgeInsets.all(8.0),
                        itemCount: widget.groupModel.classes.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          List<ClassModel> classes = widget.groupModel.classes;
                          print(classes[index].room_name);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                classes[index].day_name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  title: Text(classes[index].room_name),
                                  subtitle: Text(
                                    "${classes[index].start_time} - ${classes[index].end_time}",
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
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
        SizedBox(height: 15),
        // Timetable qismi uchun ExpansionTile
      ],
    );
  }
}
