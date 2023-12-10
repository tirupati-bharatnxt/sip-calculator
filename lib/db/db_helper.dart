import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _database;
  static DBHelper? _dbHelper;

  DBHelper._();

  factory DBHelper() {
    return _dbHelper ??= DBHelper._();
  }

  Future<Database> get database async {
    return _database ??= await initDatabase();
  }

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'sippy.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user_history (
        id INTEGER PRIMARY KEY,
        actual_amount REAL,
        profit REAL,
        periods INTEGER,
        rate_of_return REAL,
        times_rolled INTEGER,
        created_at TEXT
      )
    ''');
  }

  Future<int> insertData(Map<String, dynamic> data) async {
    Database db = await database;
    data['created_at'] = DateTime.now().toUtc().toIso8601String();
    return await db.insert('user_history', data);
  }

  Future<List<Map<String, dynamic>>> getData() async {
    Database db = await database;
    return await db.query('user_history');
  }

// Add methods for update and delete as needed
}
