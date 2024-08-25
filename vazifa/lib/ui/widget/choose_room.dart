import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/room_bloc.dart/room_bloc.dart';
import 'package:vazifa/blocs/room_bloc.dart/room_event.dart';
import 'package:vazifa/blocs/room_bloc.dart/room_state.dart';
import 'package:vazifa/blocs/timetable_bloc/timetable_bloc.dart';
import 'package:vazifa/blocs/timetable_bloc/timetable_event.dart';
import 'package:vazifa/data/model/room_model.dart';
import 'package:vazifa/ui/screens/role/admin_screen.dart';

Future ChooseRoom(
  BuildContext context,
  int group_id,
  int day_id,
  String start_time,
  String end_time,
) {
  BlocProvider.of<RoomBloc>(context).add(GetAvailableRoomsEvent(day_id: day_id, start_time: start_time, end_time: end_time));
  RoomModel? selectedRoom;

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("Xonani tanlang"),
            content: BlocBuilder<RoomBloc, RoomState>(
              builder: (context, state) {
                if (state is RoomLoadingState) {
                  return Center(
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

                  return Container(
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: rooms.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            rooms[index].name,
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(rooms[index].capacity.toString()),
                          trailing: selectedRoom == rooms[index]
                              ? Icon(Icons.check, color: Colors.green)
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
                return Center(
                  child: Text("Xonalar topilmadi!"),
                );
              },
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Bekor qilish'),
              ),
              ElevatedButton(
                onPressed: selectedRoom != null
                    ? () {
                        context.read<TimetableBloc>().add(CreateTimeTableEvent(
                            group_id: group_id,
                            room_id: selectedRoom!.id,
                            day_id: day_id,
                            start_time: start_time,
                            end_time: end_time));
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminScreen(),));
                      }
                    : null,
                child: Text("Qo'shish"),
              ),
            ],
          );
        },
      );
    },
  );
}
