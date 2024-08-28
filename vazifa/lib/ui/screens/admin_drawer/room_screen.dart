import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/room_bloc.dart/room_bloc.dart';
import 'package:vazifa/blocs/room_bloc.dart/room_event.dart';
import 'package:vazifa/blocs/room_bloc.dart/room_state.dart';
import 'package:vazifa/ui/screens/admin_drawer/manage_room.dart';
import 'package:vazifa/ui/widget/custom_drawer_for_admin.dart';
import 'package:vazifa/ui/widget/room_item.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RoomBloc>().add(GetRoomsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rooms",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      drawer: const CustomDrawerForAdmin(),
      body: BlocBuilder<RoomBloc, RoomState>(builder: (context, state) {
        if (state is RoomLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is RoomErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is RoomLoadedState) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: state.rooms.length,
            itemBuilder: (context, index) {
              return RoomItem(roomModel: state.rooms[index]);
            },
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
                builder: (context) => const ManageRoom(
                  roomModel: null,
                ),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
