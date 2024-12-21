import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';
import '../models/department.dart';

class DepartmentsNotifier extends StateNotifier<Map<Department, int>> {
  DepartmentsNotifier() : super({for (var dep in Department.values) dep: 0});

  void updateCounts(List<Student> students) {
    final updatedCounts = {
      for (var dep in Department.values)
        dep: students.where((student) => student.department == dep).length,
    };
    state = updatedCounts;
  }
}

final departmentsProvider =
    StateNotifierProvider<DepartmentsNotifier, Map<Department, int>>(
  (ref) => DepartmentsNotifier(),
);
