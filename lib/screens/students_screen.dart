import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';
import '../providers/student_provider.dart';
import '../widgets/student_item.dart';
import '../widgets/new_student.dart';

class StudentsScreen extends ConsumerWidget {
  const StudentsScreen({super.key});

  void launchStudentModal(BuildContext context, WidgetRef ref,
      {Student? student, int? index}) {
    showModalBottomSheet<Student>(
      context: context,
      isScrollControlled: true,
      builder: (_) => NewStudent(student: student),
    ).then((newStudent) {
      if (newStudent != null) {
        if (index != null) {
          ref.read(studentProvider.notifier).modifyStudent(index, newStudent);
        } else {
          ref.read(studentProvider.notifier).insertStudent(newStudent);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentProvider);

    return Scaffold(
      body: students.isEmpty
          ? const Center(
              child: Text(
                'Oops! No students!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return StudentItem(
                  student: student,
                  onDelete: () {
                    ref.read(studentProvider.notifier).expelStudent(index);
                    final provider = ProviderScope.containerOf(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${student.firstName} removed.'),
                        action: SnackBarAction(
                          label: 'Revert',
                          onPressed: () {
                            provider
                                .read(studentProvider.notifier)
                                .revertLastDeletion();
                          },
                        ),
                      ),
                    );
                  },
                  onEdit: () {
                    launchStudentModal(
                      context,
                      ref,
                      student: student,
                      index: index,
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => launchStudentModal(context, ref),
        backgroundColor: Colors.amber.shade300,
        shape: const _TriangleButtonShape(),
        child: const Icon(Icons.add, size: 28, color: Colors.white),
      ),
    );
  }
}

class _TriangleButtonShape extends ShapeBorder {
  const _TriangleButtonShape();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..moveTo(rect.width / 2, 0) // Top point
      ..lineTo(rect.width, rect.height) // Bottom-right corner
      ..lineTo(0, rect.height) // Bottom-left corner
      ..close();
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // Inner path is not used for this shape, so return the same as getOuterPath
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => const _TriangleButtonShape();
}
