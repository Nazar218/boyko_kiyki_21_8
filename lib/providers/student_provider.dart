import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';
import 'departments_provider.dart';

class StudentNotifier extends StateNotifier<List<Student>> {
  StudentNotifier(this._departmentsNotifier) : super([]);

  final DepartmentsNotifier _departmentsNotifier;

  Student? _lastDeletedStudent;
  int? _lastDeletedIndex;

  void insertStudent(Student student) {
    state = [...state, student];
    _departmentsNotifier.updateCounts(state);
  }

  void modifyStudent(int index, Student updatedStudent) {
    final updatedList = [...state];
    updatedList[index] = updatedStudent;
    state = updatedList;
    _departmentsNotifier.updateCounts(state);
  }

  void expelStudent(int index) {
    _lastDeletedStudent = state[index];
    _lastDeletedIndex = index;
    state = [...state.sublist(0, index), ...state.sublist(index + 1)];
    _departmentsNotifier.updateCounts(state);
  }

  void revertLastDeletion() {
    if (_lastDeletedStudent != null && _lastDeletedIndex != null) {
      state = [
        ...state.sublist(0, _lastDeletedIndex!),
        _lastDeletedStudent!,
        ...state.sublist(_lastDeletedIndex!),
      ];
      _departmentsNotifier.updateCounts(state);
      _lastDeletedStudent = null;
      _lastDeletedIndex = null;
    }
  }
}

final studentProvider = StateNotifierProvider<StudentNotifier, List<Student>>(
  (ref) => StudentNotifier(ref.read(departmentsProvider.notifier)),
);
