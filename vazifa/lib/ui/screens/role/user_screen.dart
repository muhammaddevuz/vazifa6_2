import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/auth_bloc/auth_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_event.dart';
import 'package:vazifa/blocs/group_bloc/group_state.dart';
import 'package:vazifa/ui/screens/group_information_screen.dart';
import 'package:vazifa/ui/screens/profile_screen.dart';
// import 'package:vazifa/ui/screens/student_group_information.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GroupBloc>().add(GetStudentGroupsEvent());
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
          'Home',
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
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: state.groups.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GroupInformationScreen(
                              groupModel: state.groups[index],
                            ),
                          ));
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Group Name: ${state.groups[index].name}",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Text(
                            "Main Teacher Id: ${state.groups[index].main_teacher.id}",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Text(
                            "Asistant Teacher id: ${state.groups[index].assistant_teacher.id}",
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
