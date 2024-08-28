// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:vazifa/data/services/authentification_interseptor.dart';

class TimetableService {
  final Dio dio;

  TimetableService() : dio = Dio() {
    dio.interceptors.add(AuthInterceptor());
  }

  Future<void> createTimetable(
    int groupId,
    int roomId,
    int dayId,
    String startTime,
    String endTime,
  ) async {
    try {
      dio.options.headers['Content-Type'] = 'application/json';

      final data = {
        "group_id": groupId,
        "room_id": roomId,
        "day_id": dayId,
        "start_time": startTime,
        "end_time": endTime
      };

      final response = await dio.post(
        'http://millima.flutterwithakmaljon.uz/api/group-classes',
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Timetable created successfully');
      } else {
        print('Failed to add Timetable: ${response.statusCode}');
        throw 'Failed to add Timetable: ${response.statusCode}';
      }
    } catch (e) {
      print('Error adding room: $e');
    }
  }

  Future<Map<String, dynamic>> getGroupTimeTables(int groupId) async {
    try {
      final response = await dio.get(
        'http://millima.flutterwithakmaljon.uz/api/group-timetable/$groupId',
      );

      if (response.data['success'] == false) {
        throw response.data;
      }
      return response.data;
    } catch (e) {
      print('Error getting rooms: $e');
      rethrow;
    }
  }
}
