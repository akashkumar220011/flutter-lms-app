import 'package:flutter/material.dart';
import 'package:lms_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../admin/admin_dashboard.dart';
import '../auth/signup.dart';
import '../student/student_dashboard.dart';
import '../teacher/teacher_dashboard.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  login() async {
    final auth = context.read<AuthProvider>();
    bool success = await auth.login(
      email: emailCtrl.text,
      password: passCtrl.text,
    );
    if (!success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Invalid credentials")));
      return;
    }
    final role = auth.currentUser!.role;
    if (role == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AdminDashboard()),
      );
    } else if (role == 'teacher') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => TeacherDashboard()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => StudentDashboard()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailCtrl,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passCtrl,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: Text("Login")),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SignupScreen()),
                );
              },
              child: Text("Don't have an account? Signup"),
            ),
          ],
        ),
      ),
    );
  }
}
