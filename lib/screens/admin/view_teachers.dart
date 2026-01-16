// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lms_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../../db/database_helper.dart';

class ViewTeachersScreen extends StatefulWidget {
  const ViewTeachersScreen({super.key});

  @override
  State<ViewTeachersScreen> createState() => _ViewTeachersScreenState();
}

class _ViewTeachersScreenState extends State<ViewTeachersScreen> {
  List<Map<String, dynamic>> teachers = [];

  @override
  void initState() {
    super.initState();
    fetchTeachers();
  }

  Future<void> fetchTeachers() async {
    final db = await DatabaseHelper.database;
    final res = await db.query(
      'users',
      where: 'role = ?',
      whereArgs: ['teacher'],
    );
    setState(() {
      teachers = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Teachers")),
      body: ListView.builder(
        itemCount: teachers.length,
        itemBuilder: (context, index) {
          final t = teachers[index];
          return ListTile(
            title: Text(t['name']),
            subtitle: Text(t['email']),
            trailing: IconButton(
              onPressed: () async {
                await context.read<AuthProvider>().deleteUser(t['id']);
                fetchTeachers();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Teacher deleted")),
                );
              },
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
