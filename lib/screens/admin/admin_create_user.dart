import 'package:flutter/material.dart';
import 'package:lms_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AdminCreateUser extends StatefulWidget {
  const AdminCreateUser({super.key});

  @override
  State<AdminCreateUser> createState() => _AdminCreateUserState();
}

class _AdminCreateUserState extends State<AdminCreateUser> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  String role = 'student';
  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();
    return Scaffold(
      appBar: AppBar(title: Text("Create User")),
      body: Padding(
        padding: EdgeInsets.all(16),
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
              decoration: InputDecoration(labelText: "Password"),
            ),

            DropdownButtonFormField<String>(
              initialValue: role,
              items: ['student', 'teacher'].map((r) {
                return DropdownMenuItem(value: r, child: Text(r.toString()));
              }).toList(),
              onChanged: (v) => setState(() => role = v!),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await auth.createUser(
                  name: nameCtrl.text,
                  email: emailCtrl.text,
                  password: passCtrl.text,
                  role: role,
                );
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("User Created")));
                Navigator.pop(context);
              },
              child: Text("Create User"),
            ),
          ],
        ),
      ),
    );
  }
}
