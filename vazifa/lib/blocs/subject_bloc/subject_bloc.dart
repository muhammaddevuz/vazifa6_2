import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/subject_bloc/subject_event.dart';
import 'package:vazifa/blocs/subject_bloc/subject_state.dart';
import 'package:vazifa/data/model/Subject_model.dart';
import 'package:vazifa/data/services/subject_service.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  SubjectBloc() : super(SubjectInitialState()) {
    on<GetSubjectEvent>(_onGetSubjects);
    on<AddSubjectEvent>(_addSubject);
    on<UpdateSubjectEvent>(_updateSubject);
    on<DeleteSubjectEvent>(_deleteSubject);
  }

  Future<void> _onGetSubjects(GetSubjectEvent event, emit) async {
    emit(SubjectLoadingState());
    final SubjectService subjectService = SubjectService();
    try {
      final response = await subjectService.getSubjects();
      List<SubjectModel> subjects = [];

      response['data'].forEach((value) {
        subjects.add(SubjectModel.fromMap(value));
      });

      emit(SubjectLoadedState(subjects: subjects));
    } catch (e) {
      emit(SubjectErrorState(error: e.toString()));
    }
  }


  Future<void> _addSubject(AddSubjectEvent event, emit) async {
    final SubjectService subjectService = SubjectService();
    try {
      await subjectService.addSubject(event.name);
      add(GetSubjectEvent());
    } catch (e) {
      emit(SubjectErrorState(error: e.toString()));
    }
  }

  Future<void> _updateSubject(UpdateSubjectEvent event, emit) async {
    final SubjectService subjectService = SubjectService();
    try {
      await subjectService.updateSubject(
          event.subjectId, event.name);
      add(GetSubjectEvent());
    } catch (e) {
      emit(SubjectErrorState(error: e.toString()));
    }
  }

  Future<void> _deleteSubject(DeleteSubjectEvent event, emit) async {
    final SubjectService subjectService = SubjectService();
    try {
      await subjectService.deleteSubject(event.subjectId);
      add(GetSubjectEvent());
    } catch (e) {
      emit(SubjectErrorState(error: e.toString()));
    }
  }
}
