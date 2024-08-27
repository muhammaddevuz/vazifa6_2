import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/subject_bloc/subject_bloc.dart';
import 'package:vazifa/blocs/subject_bloc/subject_event.dart';
import 'package:vazifa/data/model/Subject_model.dart';
import 'package:vazifa/ui/screens/admin_drawer/manage_subject.dart';

class SubjectItem extends StatelessWidget {
  final SubjectModel subjectModel;
  const SubjectItem({super.key, required this.subjectModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Name: ${subjectModel.name}"),
      subtitle: Text("Id: ${subjectModel.id}"),
      trailing: SizedBox(
        width: 96, // Width enough to fit both icons
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end, // Align icons to the end
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManageSubject(
                      subjectModel: subjectModel,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.edit,
                size: 30,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: () {
                context
                    .read<SubjectBloc>()
                    .add(DeleteSubjectEvent(subjectId: subjectModel.id));
              },
              icon: Icon(
                Icons.delete,
                size: 30,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
