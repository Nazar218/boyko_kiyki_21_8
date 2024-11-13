import 'package:flutter/material.dart';
import '../models/student.dart';
import 'student_item.dart';
import 'new_student.dart';

class StudentsScreen extends StatefulWidget {
  @override
  _StudentsScreenState createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final List<Student> _students = [
    Student(firstName: 'John', lastName: 'Doe', department: Department.finance, grade: 88, gender: Gender.male),
    Student(firstName: 'Emma', lastName: 'Smith', department: Department.law, grade: 92, gender: Gender.female),
    Student(firstName: 'Olivia', lastName: 'Brown', department: Department.it, grade: 80, gender: Gender.female),
    Student(firstName: 'Liam', lastName: 'Wilson', department: Department.medical, grade: 85, gender: Gender.male),
  ];

  void _addStudent() async {
    final newStudent = await showModalBottomSheet<Student>(
      context: context,
      isScrollControlled: true,
      builder: (_) => NewStudent(),
    );
    if (newStudent != null) {
      setState(() {
        _students.add(newStudent);
      });
    }
  }

  void _editStudent(Student student, int index) async {
    final updatedStudent = await showModalBottomSheet<Student>(
      context: context,
      isScrollControlled: true,
      builder: (_) => NewStudent(student: student),
    );
    if (updatedStudent != null) {
      setState(() {
        _students[index] = updatedStudent;
      });
    }
  }

  void _deleteStudent(int index) {
    final deletedStudent = _students[index];
    setState(() {
      _students.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${deletedStudent.firstName} removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _students.insert(index, deletedStudent);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(_students[index]),
            background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: EdgeInsets.only(right: 20), child: Icon(Icons.delete, color: Colors.white)),
            direction: DismissDirection.endToStart,
            onDismissed: (_) => _deleteStudent(index),
            child: InkWell(
              onTap: () => _editStudent(_students[index], index),
              child: StudentItem(student: _students[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStudent,
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
      ),
    );
  }
}
