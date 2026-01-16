import 'package:flutter/material.dart';
import 'package:lms_app/screens/admin/admin_create_course.dart';
import 'package:lms_app/screens/admin/admin_create_user.dart';
import 'package:lms_app/screens/admin/admin_manage_users.dart';
import 'package:lms_app/screens/admin/view_courses.dart';
import 'package:lms_app/screens/admin/view_teachers.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../auth/login.dart';
import 'view_students.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ViewStudentsScreen()),
                );
              },
              child: Text("View Students"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ViewTeachersScreen()),
                );
              },
              child: Text("View Teachers"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ViewCoursesScreen()),
                );
              },
              child: Text("View Courses"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text("Create Course"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AdminCreateCourse()),
                );
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AdminCreateUser()),
                );
              },
              child: Text("Create User"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AdminManageUsers(role: 'student'),
                  ),
                );
              },
              child: Text('Manage Student'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AdminManageUsers(role: 'teacher'),
                  ),
                );
              },
              child: Text('Manage Teachers'),
            ),
          ],
        ),
      ),
    );
  }
}
