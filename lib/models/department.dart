import 'package:flutter/material.dart';

enum Department { finance, law, it, medical }

const Map<Department, String> nameDepartment = {
  Department.finance: 'Finance',
  Department.law: 'Law',
  Department.it: 'IT',
  Department.medical: 'Medical',
};

const Map<Department, IconData> iconDepartment = {
  Department.finance: Icons.pie_chart,   
  Department.law: Icons.account_balance,    
  Department.it: Icons.memory,             
  Department.medical: Icons.favorite,        
};
