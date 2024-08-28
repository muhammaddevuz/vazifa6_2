import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/subject_bloc/subject_bloc.dart';
import 'package:vazifa/blocs/subject_bloc/subject_event.dart';
import 'package:vazifa/data/model/Subject_model.dart';
import 'package:vazifa/ui/screens/admin_drawer/subject_screen.dart';

class ManageSubject extends StatefulWidget {
  final SubjectModel? subjectModel;
  const ManageSubject({super.key, required this.subjectModel});

  @override
  State<ManageSubject> createState() => _ManageSubjectState();
}

class _ManageSubjectState extends State<ManageSubject> {
  final TextEditingController nameEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.subjectModel != null) {
      nameEditingController.text = widget.subjectModel!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.subjectModel == null ? "Add Subject" : "Edit Subject",
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 15),
            TextField(
              controller: nameEditingController,
              decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  context.read<SubjectBloc>().add(AddSubjectEvent(
                      name: nameEditingController.text,));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SubjectScreen(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10)),
                child: Text(
                  widget.subjectModel == null ? "Add Subject" : "Edit Subject",
                  style: const TextStyle(
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
