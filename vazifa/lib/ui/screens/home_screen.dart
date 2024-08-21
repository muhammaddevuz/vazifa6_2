// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vazifa/blocs/auth_bloc/auth_bloc.dart';
import 'package:vazifa/blocs/user_bloc/user_bloc.dart';
import 'package:vazifa/blocs/user_bloc/user_event.dart';
import 'package:vazifa/blocs/user_bloc/user_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              final String token = prefs.getString("token")!;

              context.read<AuthBloc>().add(LoggedOut(token: token));
              print(prefs.getString("token"));
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is UserLoadingState) {
          return Center(
            child: LinearProgressIndicator(),
          );
        }
        if (state is UserErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is UserLoadedState) {
          return Center(
            child: Text((state as UserLoadedState).user.toString()),
          );
        }
        return Center(
          child: Text("User topilmadi :("),
        );
      }),
    );
  }
}
