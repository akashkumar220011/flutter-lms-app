import 'package:flutter/material.dart';
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
          return ListTile(title: Text(t['name']),
          subtitle: Text(t['email']),);
        },
      ),
    );
  }
}
