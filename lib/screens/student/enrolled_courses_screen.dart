import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/course_provider.dart';
import '../../providers/auth_provider.dart';

class EnrolledCoursesScreen extends StatelessWidget {
  @override
Widget build(BuildContext context) {
  final auth = context.read<AuthProvider>();
  final courseProvider = context.read<CourseProvider>();

  return Scaffold(
    appBar: AppBar(title: Text("My Courses")),
    body: FutureBuilder(
      future: courseProvider.getEnrolledCourses(auth.currentUser!.id!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final courses = snapshot.data!;

        if (courses.isEmpty) {
          return Center(child: Text("No enrolled courses"));
        }

        return ListView.builder(
          itemCount: courses.length,
          itemBuilder: (_, i) {
            final course = courses[i];
            return ListTile(
              title: Text(course.title),
              subtitle: Text(course.description),
            );
          },
        );
      },
    ),
  );
}

}
