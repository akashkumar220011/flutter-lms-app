import 'package:flutter/material.dart';
import 'package:lms_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  String role = 'student';

  signup() async {
    final auth = context.read<AuthProvider>();

    bool success = await auth.signup(
      name: nameCtrl.text,
      email: emailCtrl.text,
      password: passCtrl.text,
      role: role,
    );
    if (!success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Email already exists")));
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Account created, please login")));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailCtrl,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: passCtrl,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: role,
                decoration: InputDecoration(labelText: "Role"),
                items: ['admin', 'teacher', 'student']
                    .map(
                      (r) => DropdownMenuItem(
                        value: r,
                        child: Text(r.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    role = val!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: signup, child: Text("Create Account")),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
