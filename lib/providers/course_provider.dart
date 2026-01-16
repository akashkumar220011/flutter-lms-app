import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/course_model.dart';

class CourseProvider extends ChangeNotifier {
  List<CourseModel> _courses = [];

  List<CourseModel> get courses => _courses;

  Future<void> createCourse(CourseModel course) async {
    final db = await DatabaseHelper.database;
    await db.insert('courses', course.toMap());
    await fetchAllCourses();
  }

  Future<void> fetchAllCourses() async {
    final db = await DatabaseHelper.database;
    final result = await db.query('courses');

    _courses = result.map((e) => CourseModel.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> fetchTeacherCourses(int teacherId) async {
    final db = await DatabaseHelper.database;
    final result = await db.query(
      'courses',
      where: 'teacherId = ?',
      whereArgs: [teacherId],
    );

    _courses = result.map((e) => CourseModel.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> enrollCourse({
    required int studentId,
    required int courseId,
  }) async {
    final db = await DatabaseHelper.database;

    await db.insert('enrollments', {
      'studentId': studentId,
      'courseId': courseId,
    });
  }

  Future<List<CourseModel>> getEnrolledCourses(int studentId) async {
    final db = await DatabaseHelper.database;

    final result = await db.rawQuery(
      '''
      SELECT courses.*
      FROM courses
      INNER JOIN enrollments
      ON courses.id = enrollments.courseId
      WHERE enrollments.studentId = ?
    ''',
      [studentId],
    );

    return result.map((e) => CourseModel.fromMap(e)).toList();
  }

  Future<void> createCourseByAdmin({
    required String title,
    required String description,
    required int teacherId,
  }) async {
    final db = await DatabaseHelper.database;

    await db.insert('courses', {
      'title': title,
      'description': description,
      'teacherId': teacherId,
    });
    await fetchAllCourses();
  }
}
