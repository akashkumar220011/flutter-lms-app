// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lms_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
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
          return ListTile(
            title: Text(s['name']),
            subtitle: Text(s['email']),
            trailing: IconButton(
              onPressed: () async {
                await context.read<AuthProvider>().deleteUser(s['id']);
                fetchStudents();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Student deleted")),
                );
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
