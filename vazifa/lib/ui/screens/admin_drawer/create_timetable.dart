import 'package:flutter/material.dart';
import 'package:vazifa/ui/widget/choose_room.dart';

class CreateTimetable extends StatefulWidget {
  final int groupId;
  CreateTimetable({required this.groupId});
  @override
  _CreateTimetableState createState() => _CreateTimetableState();
}

class _CreateTimetableState extends State<CreateTimetable> {
  int? selectedDayIndex;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  final List<String> weekDays = [
    'Dushanba',
    'Seshanba',
    'Chorshanba',
    'Payshanba',
    'Juma',
    'Shanba',
    'Yakshanba',
  ];

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? TimeOfDay.now() : startTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Timetable",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<int>(
              hint: Text("Hafta kunini tanlang"),
              value: selectedDayIndex,
              onChanged: (newValue) {
                setState(() {
                  selectedDayIndex = newValue;
                });
              },
              items: weekDays.asMap().entries.map((entry) {
                int idx = entry.key;
                String day = entry.value;
                return DropdownMenuItem(
                  value: idx,
                  child: Text(day),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Boshlanish vaqti:"),
                ElevatedButton(
                  onPressed: () => _selectTime(context, true),
                  child: Text(startTime == null
                      ? "Tanlash"
                      : startTime!.format(context)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tugash vaqti:"),
                ElevatedButton(
                  onPressed: () => _selectTime(context, false),
                  child: Text(
                      endTime == null ? "Tanlash" : endTime!.format(context)),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: selectedDayIndex != null &&
                      startTime != null &&
                      endTime != null
                  ? () async {
                      String start = startTime!.format(context);
                      String end = endTime!.format(context);
                      if (start.split(' ')[1] == 'PM') {
                        start =
                            "${int.parse(start.split(" ")[0].split(":")[0]) + 12}:${start.split(" ")[0].split(":")[1]}";
                      } else if (start.split(" ")[0].split(":")[0].length ==
                          1) {
                        start = "0${start.split(' ')[0]}";
                      } else {
                        start = start.split(' ')[0];
                      }
                      if (end.split(' ')[1] == 'PM') {
                        end =
                            "${int.parse(end.split(" ")[0].split(":")[0]) + 12}:${end.split(" ")[0].split(":")[1]}";
                      } else if (end.split(" ")[0].split(":")[0].length == 1) {
                        end = "0${end.split(' ')[0]}";
                      } else {
                        end = end.split(' ')[0];
                      }
                      print(end);
                      print(start);
                      await ChooseRoom(context, widget.groupId,
                          (selectedDayIndex! + 1), start, end);
                    }
                  : null,
              child: Text("Get Rooms"),
            ),
          ],
        ),
      ),
    );
  }
}
