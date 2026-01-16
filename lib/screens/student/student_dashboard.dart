import 'package:flutter/material.dart';
import 'package:lms_app/providers/auth_provider.dart';
import 'package:lms_app/screens/auth/login.dart';
import 'package:provider/provider.dart';
import 'all_courses_screen.dart';
import 'enrolled_courses_screen.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Dashboard"),
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
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              child: Text("All Courses"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AllCoursesScreen()),
                );
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text("My Enrolled Courses"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EnrolledCoursesScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
