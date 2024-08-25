import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/auth_bloc/auth_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_event.dart';
import 'package:vazifa/blocs/group_bloc/group_state.dart';
import 'package:vazifa/ui/widget/custom_drawer_for_admin.dart';
import 'package:vazifa/ui/widget/group_item_for_admin.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GroupBloc>().add(GetGroupsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawerForAdmin(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              context.read<AuthBloc>().add(LoggedOut());
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
        title: Text(
          "Admin Panel",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
              return GroupItemForAdmin(groupModel: state.groups[index]);
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
