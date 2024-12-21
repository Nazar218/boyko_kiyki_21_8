import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/department.dart';

class StudentItem extends StatelessWidget {
  final Student student;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const StudentItem({
    super.key,
    required this.student,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final Color cardColor =
        student.gender == Gender.male ? Colors.blue.shade100 : Colors.pink.shade100;

    return Dismissible(
      key: ValueKey(student),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: student.gender == Gender.male
                ? [Colors.blue.shade200, Colors.blue.shade400]
                : [Colors.pink.shade200, Colors.pink.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          leading: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              departmentIcons[student.department],
              color: student.gender == Gender.male ? Colors.blue : Colors.pink,
              size: 30,
            ),
          ),
          title: Text(
            '${student.firstName} ${student.lastName}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            nameDepartment[student.department]!,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: onEdit,
          ),
        ),
      ),
    );
  }
}
