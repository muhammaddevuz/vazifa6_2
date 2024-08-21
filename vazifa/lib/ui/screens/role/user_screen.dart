import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/auth_bloc/auth_bloc.dart';
import 'package:vazifa/blocs/user_bloc/user_bloc.dart';
import 'package:vazifa/blocs/user_bloc/user_state.dart';
import 'package:vazifa/ui/screens/profile_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
          
            return Center(
              child: Text(state.user.name),
            );
        }
        return Center(
          child: Text("User topilmadi!"),
        );
      }),
    );
  }
}