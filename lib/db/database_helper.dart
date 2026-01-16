import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), "lms.db");

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, v) async {
        await db.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          email TEXT UNIQUE,
          password TEXT,
          role TEXT
        )
  ''');
        await db.execute('''
          CREATE TABLE courses(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            teacherId INTEGER
          )
''');
        await db.execute('''
          CREATE TABLE enrollments(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            studentId INTEGER,
            courseId INTEGER
          )
''');
      },
    );
  }
}
