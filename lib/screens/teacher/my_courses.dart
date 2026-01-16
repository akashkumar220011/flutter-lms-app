import 'package:flutter/material.dart';
import 'package:lms_app/providers/auth_provider.dart';
import 'package:lms_app/providers/course_provider.dart';
import 'package:provider/provider.dart';

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({super.key});

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final auth = context.read<AuthProvider>();
      final courseProvider = context.read<CourseProvider>();
      courseProvider.fetchTeacherCourses(auth.currentUser!.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<CourseProvider>().courses;
    return Scaffold(
      appBar: AppBar(title: Text("My  Courses")),
      body: courses.isEmpty
          ? Center(child: Text("No courses yet"))
          : ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final c = courses[index];
                return ListTile(
                  title: Text(c.title),
                  subtitle: Text(c.description),
                );
              },
            ),
    );
  }
}
