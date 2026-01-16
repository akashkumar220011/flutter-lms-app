import 'package:flutter/material.dart';
import '../../db/database_helper.dart';

class ViewStudentsScreen extends StatefulWidget {
  const ViewStudentsScreen({super.key});

  @override
  State<ViewStudentsScreen> createState() => _ViewStudentsScreenState();
}

class _ViewStudentsScreenState extends State<ViewStudentsScreen> {
  List<Map<String, dynamic>> students = [];
  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    final db = await DatabaseHelper.database;
    final res = await db.query(
      'users',
      where: 'role= ?',
      whereArgs: ['student'],
    );
    setState(() {
      students = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Students')),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final s = students[index];
          return ListTile(title: Text(s['name']), subtitle: Text(s['email']));
        },
      ),
    );
  }
}
