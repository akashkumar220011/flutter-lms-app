import 'package:flutter/material.dart';
import 'package:lms_app/providers/auth_provider.dart';
import 'package:lms_app/screens/teacher/create_course.dart';
import 'package:lms_app/screens/teacher/my_courses.dart';
import 'package:provider/provider.dart';

import '../auth/login.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final teacher = auth.currentUser!;
    return Scaffold(
      appBar: AppBar(title: Text("Teacher Dashboard"),
      actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              context.read<AuthProvider>().logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
                (_) => false,
              );
            },
          ),
        ],),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Welcome, ${teacher.name}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CreateCourseScreen()),
                );
              },
              child: Text("Create Course"),
            ),

            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MyCoursesScreen()),
                );
              },
              child: Text("My Course"),
            ),
          ],
        ),
      ),
    );
  }
}
