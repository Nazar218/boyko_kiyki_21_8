import 'package:flutter/material.dart';
import '../models/students.dart';

class StudentItem extends StatelessWidget {
  final Student student;

  const StudentItem({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color genderColor = student.gender == Gender.male ? Colors.indigo : Colors.orange;

    return Card(
      elevation: 5,
      shadowColor: genderColor.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: genderColor.withOpacity(0.7),
          child: Icon(
            departmentIcons[student.department],
            color: Colors.white,
          ),
        ),
        title: Text(
          '${student.firstName} ${student.lastName}',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.grey[800],
          ),
        ),
        subtitle: Text(
          'Grade: ${student.grade}',
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: genderColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.star,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
