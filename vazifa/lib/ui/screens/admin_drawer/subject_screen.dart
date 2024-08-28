import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/subject_bloc/subject_bloc.dart';
import 'package:vazifa/blocs/subject_bloc/subject_event.dart';
import 'package:vazifa/blocs/subject_bloc/subject_state.dart';
import 'package:vazifa/ui/screens/admin_drawer/manage_subject.dart';
import 'package:vazifa/ui/widget/custom_drawer_for_admin.dart';
import 'package:vazifa/ui/widget/subject_item.dart';
class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SubjectBloc>().add(GetSubjectEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Subjects",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      drawer: const CustomDrawerForAdmin(),
      body: BlocBuilder<SubjectBloc, SubjectState>(builder: (context, state) {
        if (state is SubjectLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SubjectErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is SubjectLoadedState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: state.subjects.length,
              itemBuilder: (context, index) {
                return SubjectItem(subjectModel: state.subjects[index]);
              },
            ),
          );
        }
        return const Center(
          child: Text("Roomlar topilmadi!"),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ManageSubject(
                  subjectModel: null,
                ),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
