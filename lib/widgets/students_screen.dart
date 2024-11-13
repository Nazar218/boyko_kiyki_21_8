import 'package:flutter/material.dart';
import '../models/student.dart';
import 'student_item.dart';

class StudentsScreen extends StatelessWidget {
  final List<Student> students = [
    Student(firstName: 'John', lastName: 'Doe', department: Department.finance, grade: 88, gender: Gender.male),
    Student(firstName: 'Emma', lastName: 'Smith', department: Department.law, grade: 92, gender: Gender.female),
    Student(firstName: 'Olivia', lastName: 'Brown', department: Department.it, grade: 80, gender: Gender.female),
    Student(firstName: 'Liam', lastName: 'Wilson', department: Department.medical, grade: 85, gender: Gender.male),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Students',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return StudentItem(student: students[index]);
        },
      ),
    );
  }
}
