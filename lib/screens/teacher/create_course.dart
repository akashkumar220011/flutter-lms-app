import 'package:flutter/material.dart';
import 'package:lms_app/models/course_model.dart';
import 'package:lms_app/providers/auth_provider.dart';
import 'package:lms_app/providers/course_provider.dart';
import 'package:provider/provider.dart';

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({super.key});

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

 Future<void> createCourse() async {
    final auth = context.read<AuthProvider>();
    final courseProvider = context.read<CourseProvider>();
    final teacherId = auth.currentUser!.id!;

    final course = CourseModel(
      title: titleCtrl.text,
      description: descCtrl.text,
      teacherId: teacherId,
    );
    await courseProvider.createCourse(course);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Course created")));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Course")),
      body: Padding(padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: titleCtrl,
            decoration: InputDecoration(labelText: "Course Title"),
          ),
          SizedBox(height: 20),
          TextField(
            controller: descCtrl,
            decoration: InputDecoration(labelText: "Course Description"),
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: createCourse, child: Text("Create"))
        ],
      ),),
    );
  }
}
