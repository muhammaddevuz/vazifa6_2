// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/current_user_bloc/current_user_bloc.dart';
import 'package:vazifa/blocs/current_user_bloc/current_user_event.dart';
import 'package:vazifa/blocs/current_user_bloc/current_user_state.dart';
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
    context.read<CurrentUserBloc>().add(GetCurrentUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CurrentUserBloc, CurrentUserState>(builder: (context, state) {
        if (state is CurrentUserLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CurrentUserErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is CurrentUserLoadedState) {
          if (state.user.role == 1) {
            return const UserScreen();
          } else if (state.user.role == 2) {
            return const TeacherScreeen();
          } else if (state.user.role == 3) {
            return const AdminScreen();
          }
        }
        return const Center(
          child: Text("User topilmadi!"),
        );
      }),
    );
  }
}
