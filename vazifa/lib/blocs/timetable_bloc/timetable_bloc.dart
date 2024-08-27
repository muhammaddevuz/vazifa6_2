import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/timetable_bloc/timetable_event.dart';
import 'package:vazifa/blocs/timetable_bloc/timetable_state.dart';
import 'package:vazifa/data/model/timetable.dart';
import 'package:vazifa/data/services/timetable_service.dart';

class TimetableBloc extends Bloc<TimeTableEvent, TimeTableState> {
  TimetableBloc() : super(TimeTableInitialState()) {
    on<GetTimeTablesEvent>(_onGetTimetables);
    on<CreateTimeTableEvent>(_addTimetable);
  }

  Future<void> _onGetTimetables(GetTimeTablesEvent event, emit) async {
    emit(TimeTableLoadingState());
    final TimetableService timetableService = TimetableService();
    try {
      final Map<String, dynamic> response =
          await timetableService.getGroupTimeTables(event.group_id);
      dynamic box = response['data'];
      if (box.isEmpty) {
        emit(TimeTableLoadedState(TimeTables: null));
      } else {
        Timetable timeTable = Timetable.fromMap(response['data']);
        emit(TimeTableLoadedState(TimeTables: timeTable));
      }
    } catch (e) {
      emit(TimeTableErrorState(error: e.toString()));
    }
  }

  Future<void> _addTimetable(CreateTimeTableEvent event, emit) async {
    final TimetableService timetableService = TimetableService();
    try {
      await timetableService.createTimetable(event.group_id, event.room_id,
          event.day_id, event.start_time, event.end_time);
    } catch (e) {
      emit(TimeTableErrorState(error: e.toString()));
    }
  }
}
