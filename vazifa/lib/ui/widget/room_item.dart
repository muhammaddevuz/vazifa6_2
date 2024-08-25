import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/room_bloc.dart/room_bloc.dart';
import 'package:vazifa/blocs/room_bloc.dart/room_event.dart';
import 'package:vazifa/data/model/room_model.dart';
import 'package:vazifa/ui/screens/admin_drawer/manage_room.dart';

class RoomItem extends StatelessWidget {
  final RoomModel roomModel;
  const RoomItem({super.key, required this.roomModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.blue),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Room Name: ${roomModel.name}",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Text(
                "Descripstion: ${roomModel.description}",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Capacity: ${roomModel.capacity}",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ManageRoom(
                                    roomModel: roomModel,
                                  ),
                                ));
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 30,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {
                            context
                                .read<RoomBloc>()
                                .add(DeleteRoomEvent(roomId: roomModel.id));
                          },
                          icon: Icon(
                            Icons.delete,
                            size: 30,
                            color: Colors.red,
                          )),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
