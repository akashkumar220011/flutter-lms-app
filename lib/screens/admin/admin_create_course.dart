import 'package:flutter/material.dart';
import 'package:lms_app/models/user_model.dart';
import 'package:lms_app/providers/auth_provider.dart';
import 'package:lms_app/providers/course_provider.dart';
import 'package:provider/provider.dart';

class AdminCreateCourse extends StatefulWidget {
  const AdminCreateCourse({super.key});

  @override
  State<AdminCreateCourse> createState() => _AdminCreateCourseState();
}

class _AdminCreateCourseState extends State<AdminCreateCourse> {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  int? selectedTecherId;
  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final courseProvider = context.read<CourseProvider>();
    return Scaffold(
      appBar: AppBar(title: Text("Create Course(Admin)")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: InputDecoration(labelText: "Course Title"),
            ),
            TextField(
              controller: descCtrl,
              decoration: InputDecoration(labelText: "Description"),
            ),
            SizedBox(height: 15),

            FutureBuilder<List<UserModel>>(
              future: authProvider.getTeachers(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final teachers = snapshot.data!;
                return DropdownButtonFormField<int>(
                  value: selectedTecherId,
                  hint: Text("Select Teacher"),
                  items: teachers.map((t) {
                    return DropdownMenuItem(value: t.id, child: Text(t.name));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedTecherId = value;
                    });
                  },
                );
              },
            ),

            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Create & Assign"),
              onPressed: () async {
                if (selectedTecherId == null) return;

                await courseProvider.createCourseByAdmin(
                  title: titleCtrl.text,
                  description: descCtrl.text,
                  teacherId: selectedTecherId!,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Course Created & Assigned")),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
