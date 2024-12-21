import 'package:flutter/material.dart';
import 'students_screen.dart';
import 'departments_screen.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainTabScreen> {
  int _currentTabIndex = 0;

  final List<Widget> _pages = [
    const DepartmentScreen(),
    const StudentsScreen(),
  ];

  final List<String> pageNames = [
    'Departments',
    'Students',
  ];

  void _handleTabChange(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pageNames[_currentTabIndex],
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: _pages[_currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: _handleTabChange,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Departments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Students',
          ),
        ],
      ),
    );
  }
}
