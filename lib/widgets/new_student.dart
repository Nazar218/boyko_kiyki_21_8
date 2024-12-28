import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/department.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/student_provider.dart';


class NewStudent extends ConsumerStatefulWidget {
  const NewStudent({
    super.key,
    this.studentIndex
  });

  final int? studentIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewStudentState();
}

class _NewStudentState extends ConsumerState<NewStudent> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  Department _selectedDepartment = Department.finance;
  Gender _selectedGender = Gender.female;
  int _selectedGrade = 1;

  @override
  void initState() {
    super.initState();
    if (widget.studentIndex != null) {
      final student = ref.read(studentProvider).list[widget.studentIndex!];
      _firstNameController.text = student.firstName;
      _lastNameController.text = student.lastName;
      _selectedGender = student.gender;
      _selectedDepartment = student.department;
      _selectedGrade = student.grade;
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _saveStudent() async {
    if (widget.studentIndex == null)  {
      await ref.read(studentProvider.notifier).insertStudent(
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            _selectedDepartment,
            _selectedGender,
            _selectedGrade,
          );
    } else {
      await ref.read(studentProvider.notifier).modifyStudent(
            widget.studentIndex!,
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            _selectedDepartment,
            _selectedGender,
            _selectedGrade,
          );
    }

    if (!context.mounted) return;
    Navigator.of(context).pop(); 
  }

  @override
  Widget build(BuildContext context) {
    final students = ref.watch(studentProvider);
    if (students.dueLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<Department>(
                value: _selectedDepartment,
                items: Department.values
                    .map(
                      (dept) => DropdownMenuItem(
                        value: dept,
                        child: Row(
                          children: [
                            Icon(iconDepartment[dept], color: Colors.teal),
                            const SizedBox(width: 8),
                            Text(nameDepartment[dept]!),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _selectedDepartment = value!),
                decoration: const InputDecoration(
                  labelText: 'Department',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<Gender>(
                value: _selectedGender,
                items: Gender.values
                    .map(
                      (gen) => DropdownMenuItem(
                        value: gen,
                        child: Text(
                          gen.toString().split('.').last,
                          style: const TextStyle(color: Colors.teal),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _selectedGender = value!),
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Grade:', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Slider(
                      value: _selectedGrade.toDouble(),
                      min: 1,
                      max: 100,
                      divisions: 100,
                      label: _selectedGrade.toString(),
                      onChanged: (value) =>
                          setState(() => _selectedGrade = value.toInt()),
                    ),
                  ),
                  Text(
                    _selectedGrade.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveStudent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  elevation: 5,
                  shadowColor: Colors.teal.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 20,
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Save Student',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
