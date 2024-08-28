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
      drawer: const CustomDrawerForAdmin(),
      appBar: AppBar(
        title: Text(
          widget.role == 1
              ? "Students"
              : widget.role == 2
                  ? "Teachers"
                  : "Admins",
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
        if (state is UsersLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UsersErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is UsersLoadedState) {
          List<UserModel> roleUsers = [];
          for (var element in state.users) {
              if (element.role == widget.role) {
                roleUsers.add(element);
              }
            }
          return ListView.builder(
            itemCount: roleUsers.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  roleUsers[index].name,
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: Text(roleUsers[index].phone!),
                leading: CircleAvatar(
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                    clipBehavior: Clip.hardEdge,
                    child: roleUsers[index].photo == null
                        ? const Icon(
                            Icons.person,
                            size: 40,
                          )
                        : Image.network(
                            "http://millima.flutterwithakmaljon.uz/storage/avatars/${roleUsers[index].photo}"),
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: Text("User topilmadi!"),
        );
      }),
    );
  }
}
