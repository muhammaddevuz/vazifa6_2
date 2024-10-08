import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/room_bloc.dart/room_bloc.dart';
import 'package:vazifa/blocs/room_bloc.dart/room_event.dart';
import 'package:vazifa/blocs/room_bloc.dart/room_state.dart';
import 'package:vazifa/blocs/timetable_bloc/timetable_bloc.dart';
import 'package:vazifa/blocs/timetable_bloc/timetable_event.dart';
import 'package:vazifa/data/model/room_model.dart';
import 'package:vazifa/ui/screens/role/admin_screen.dart';

Future chooseRoom(
  BuildContext context,
  int groupId,
  int dayId,
  String startTime,
  String endTime,
) {
  BlocProvider.of<RoomBloc>(context).add(GetAvailableRoomsEvent(dayId: dayId, startTime: startTime, endTime: endTime));
  RoomModel? selectedRoom;

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("Xonani tanlang"),
            content: BlocBuilder<RoomBloc, RoomState>(
              builder: (context, state) {
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
                  List<RoomModel> rooms = state.rooms;

                  return SizedBox(
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: rooms.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            rooms[index].name,
                            style: const TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(rooms[index].capacity.toString()),
                          trailing: selectedRoom == rooms[index]
                              ? const Icon(Icons.check, color: Colors.green)
                              : null,
                          onTap: () {
                            setState(() {
                              selectedRoom = rooms[index];
                            });
                          },
                        );
                      },
                    ),
                  );
                }
                return const Center(
                  child: Text("Xonalar topilmadi!"),
                );
              },
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Bekor qilish'),
              ),
              ElevatedButton(
                onPressed: selectedRoom != null
                    ? () {
                        context.read<TimetableBloc>().add(CreateTimeTableEvent(
                            groupId: groupId,
                            roomId: selectedRoom!.id,
                            dayId: dayId,
                            startTime: startTime,
                            endTime: endTime));
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminScreen(),));
                      }
                    : null,
                child: const Text("Qo'shish"),
              ),
            ],
          );
        },
      );
    },
  );
}
