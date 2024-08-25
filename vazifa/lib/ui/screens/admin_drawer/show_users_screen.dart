import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/users_bloc/users_bloc.dart';
import 'package:vazifa/blocs/users_bloc/users_event.dart';
import 'package:vazifa/blocs/users_bloc/users_state.dart';
import 'package:vazifa/data/model/user_model.dart';
import 'package:vazifa/ui/widget/custom_drawer_for_admin.dart';

class ShowUsersScreen extends StatefulWidget {
  final int role;
  const ShowUsersScreen({super.key, required this.role});

  @override
  State<ShowUsersScreen> createState() => _ShowUsersScreenState();
}

class _ShowUsersScreenState extends State<ShowUsersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(GetUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawerForAdmin(),
      appBar: AppBar(
        title: Text(
          widget.role == 1
              ? "Students"
              : widget.role == 2
                  ? "Teachers"
                  : "Admins",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
        if (state is UsersLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UsersErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is UsersLoadedState) {
          List<UserModel> role_users = [];
          state.users.forEach(
            (element) {
              if (element.role == widget.role) {
                role_users.add(element);
              }
            },
          );
          return ListView.builder(
            itemCount: role_users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  role_users[index].name,
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(role_users[index].phone),
                leading: CircleAvatar(
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                    clipBehavior: Clip.hardEdge,
                    child: role_users[index].photo == null
                        ? Icon(
                            Icons.person,
                            size: 40,
                          )
                        : Image.network(
                            "http://millima.flutterwithakmaljon.uz/storage/avatars/${role_users[index].photo}"),
                  ),
                ),
              );
            },
          );
        }
        return Center(
          child: Text("User topilmadi!"),
        );
      }),
    );
  }
}
