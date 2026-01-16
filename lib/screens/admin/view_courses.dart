import 'package:flutter/material.dart';
import 'package:lms_app/providers/course_provider.dart';
import 'package:provider/provider.dart';

class ViewCoursesScreen extends StatefulWidget {
  const ViewCoursesScreen({super.key});

  @override
  State<ViewCoursesScreen> createState() => _ViewCoursesScreenState();
}

class _ViewCoursesScreenState extends State<ViewCoursesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CourseProvider>().fetchAllCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<CourseProvider>().courses;
    return Scaffold(
      appBar: AppBar(title: Text("All Courses")),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final c = courses[index];
          return ListTile(title: Text(c.title), subtitle: Text(c.description));
        },
      ),
    );
  }
}
