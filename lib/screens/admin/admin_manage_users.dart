import 'package:flutter/material.dart';
import 'package:lms_app/models/user_model.dart';
import 'package:lms_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AdminManageUsers extends StatelessWidget {
  final String role;
  AdminManageUsers({required this.role});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();
    return Scaffold(
      appBar: AppBar(title: Text("Manage ${role}s")),
      body: FutureBuilder<List<UserModel>>(
        future: role == 'student' ? auth.getStudents() : auth.getTeachers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (_, i) {
              final user = users[i];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
                trailing: IconButton(
                  onPressed: () async {
                    await auth.deleteUser(user.id!);
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("${role} deleted")));
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
