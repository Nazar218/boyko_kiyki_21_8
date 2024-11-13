import 'package:flutter/material.dart';
import '../models/student.dart';

class NewStudent extends StatefulWidget {
  final Student? student;

  const NewStudent({Key? key, this.student}) : super(key: key);

  @override
  _NewStudentState createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  Department? _selectedDepartment;
  Gender? _selectedGender;

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _firstNameController.text = widget.student!.firstName;
      _lastNameController.text = widget.student!.lastName;
      _gradeController.text = widget.student!.grade.toString();
      _selectedDepartment = widget.student!.department;
      _selectedGender = widget.student!.gender;
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _gradeController.dispose();
    super.dispose();
  }

  void _saveStudent() {
    final newStudent = Student(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      department: _selectedDepartment!,
      grade: int.tryParse(_gradeController.text) ?? 0,
      gender: _selectedGender!,
    );
    Navigator.of(context).pop(newStudent);
  }

  void _cancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: _gradeController,
                decoration: InputDecoration(labelText: 'Grade'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 12.0),
              DropdownButtonFormField<Department>(
                value: _selectedDepartment,
                items: Department.values
                    .map((dept) => DropdownMenuItem(
                          value: dept,
                          child: Text(dept.toString().split('.').last),
                        ))
                    .toList(),
                onChanged: (dept) {
                  setState(() {
                    _selectedDepartment = dept;
                  });
                },
                decoration: InputDecoration(labelText: 'Department'),
              ),
              DropdownButtonFormField<Gender>(
                value: _selectedGender,
                items: Gender.values
                    .map((gen) => DropdownMenuItem(
                          value: gen,
                          child: Text(gen.toString().split('.').last),
                        ))
                    .toList(),
                onChanged: (gen) {
                  setState(() {
                    _selectedGender = gen;
                  });
                },
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _cancel,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _saveStudent,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
