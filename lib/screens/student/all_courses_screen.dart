import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/course_provider.dart';
import '../../providers/auth_provider.dart';

class AllCoursesScreen extends StatelessWidget {
  @override
Widget build(BuildContext context) {
  final courseProvider = context.read<CourseProvider>();
  final auth = context.read<AuthProvider>();

  return Scaffold(
    appBar: AppBar(title: Text("All Courses")),
    body: FutureBuilder(
      future: courseProvider.fetchAllCourses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final courses = context.watch<CourseProvider>().courses;

        return ListView.builder(
          itemCount: courses.length,
          itemBuilder: (_, i) {
            final course = courses[i];

            return ListTile(
              title: Text(course.title),
              subtitle: Text(course.description),
              trailing: ElevatedButton(
                child: Text("Enroll"),
                onPressed: () async {
                  await courseProvider.enrollCourse(
                    studentId: auth.currentUser!.id!,
                    courseId: course.id!,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Enrolled")),
                  );
                },
              ),
            );
          },
        );
      },
    ),
  );
}

}
