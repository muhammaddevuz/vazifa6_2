// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/user_bloc/user_bloc.dart';
import 'package:vazifa/blocs/user_bloc/user_event.dart';
import 'package:vazifa/blocs/user_bloc/user_state.dart';
import 'package:vazifa/ui/screens/role/admin_screen.dart';
import 'package:vazifa/ui/screens/role/teacher_screeen.dart';
import 'package:vazifa/ui/screens/role/user_screen.dart';

class ManagmentScreen extends StatefulWidget {
  const ManagmentScreen({super.key});

  @override
  State<ManagmentScreen> createState() => _ManagmentScreenState();
}

class _ManagmentScreenState extends State<ManagmentScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is UserLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UserErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is UserLoadedState) {
          if (state.user.role == 1) {
            return UserScreen();
          } else if (state.user.role == 2) {
            return TeacherScreeen();
          } else if (state.user.role == 3) {
            return AdminScreen();
          }
        }
        return Center(
          child: Text("User topilmadi!"),
        );
      }),
    );
  }
}
