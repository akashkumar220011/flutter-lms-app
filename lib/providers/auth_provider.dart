import 'package:flutter/material.dart';
import 'package:lms_app/db/database_helper.dart';
import 'package:lms_app/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? currentUser;

  Future<bool> signup({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    final db = await DatabaseHelper.database;

    try {
      await db.insert('users', {
        'name': name,
        'email': email,
        'password': password,
        'role': role,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    final db = await DatabaseHelper.database;

    final res = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (res.isNotEmpty) {
      currentUser = UserModel(
        id: res.first['id'] as int,
        name: res.first['name'] as String,
        email: res.first['email'] as String,
        role: res.first['role'] as String,
      );
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<List<UserModel>> getTeachers() async {
    final db = await DatabaseHelper.database;

    final result = await db.query(
      'users',
      where: 'role = ?',
      whereArgs: ['teacher'],
    );
    return result.map((e) => UserModel.fromMap(e)).toList();
  }

  void logout() {
    currentUser = null;
    notifyListeners();
  }

  Future<void> createUser({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    final db = await DatabaseHelper.database;

    await db.insert('users', {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    });
  }

  Future<List<UserModel>> getStudents() async {
    final db = await DatabaseHelper.database;

    final result = await db.query(
      'users',
      where: 'role = ?',
      whereArgs: ['student'],
    );
    return result.map((e) => UserModel.fromMap(e)).toList();
  }

  Future<void> deleteUser(int userId) async {
    final db = await DatabaseHelper.database;

    await db.delete('users', where: 'id= ?', whereArgs: [userId]);
  }
}
