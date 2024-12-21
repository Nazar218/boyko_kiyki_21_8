import 'package:flutter/material.dart';
import '../models/department.dart';

enum Gender { male, female }

class Student {
  final String firstName;
  final String lastName;
  final Department department;
  final int grade;
  final Gender gender;

  Student({
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.grade,
    required this.gender,
  });
}

const Map<Department, IconData> departmentIcons = {
  Department.finance: Icons.trending_up,
  Department.law: Icons.balance,
  Department.it: Icons.code,
  Department.medical: Icons.local_pharmacy,
};
