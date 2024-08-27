import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/auth_bloc/auth_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_event.dart';
import 'package:vazifa/blocs/group_bloc/group_state.dart';
import 'package:vazifa/ui/screens/profile_screen.dart';
import 'package:vazifa/ui/widget/group_item_for_student.dart';

class TeacherScreeen extends StatefulWidget {
  const TeacherScreeen({super.key});

  @override
  State<TeacherScreeen> createState() => _TeacherScreeenState();
}

class _TeacherScreeenState extends State<TeacherScreeen> {
  @override
  void initState() {
    super.initState();
    context.read<GroupBloc>().add(GetTeacherGroupsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ));
            },
            icon: Icon(
              Icons.person,
              size: 30,
            )),
        title: const Text(
          'Teacher Panel',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              context.read<AuthBloc>().add(LoggedOut());
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: BlocBuilder<GroupBloc, GroupState>(builder: (context, state) {
        if (state is GroupLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GroupErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is GroupLoadedState) {
          if (state.groups.length == 0) {
            return Center(
              child: Text("Guruxlar mavjud emas"),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: state.groups.length,
            itemBuilder: (context, index) {
              return GroupItemForStudent(groupModel: state.groups[index]);
            },
          );
        }
        return Center(
          child: Text("Grouplar topilmadi!"),
        );
      }),
    );
  }
}
