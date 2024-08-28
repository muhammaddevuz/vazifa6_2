class ClassModel {
  int id;
  String roomName;
  String dayName;
  String startTime;
  String endTime;

  ClassModel({
    required this.id,
    required this.roomName,
    required this.dayName,
    required this.startTime,
    required this.endTime,
  });

  // Factory constructor for creating a ClassModel from a map
  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      id: map['id'],
      roomName: map['room']['name'],
      dayName: map['day']['name'],
      startTime: map['start_time'],
      endTime: map['end_time'],
    );
  }

  // Method to convert ClassModel to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'room_id': roomName,
      'day_id': dayName,
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}
