import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'preferences.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE preferences(id INTEGER PRIMARY KEY, key TEXT, value TEXT)',
        );
      },
    );
  }

  Future<void> insertPreference(String key, String value) async {
    final db = await database;
    await db.insert(
      'preferences',
      {'key': key, 'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, String>> getPreferences() async {
    final db = await database;
    final maps = await db.query('preferences');

    return Map.fromIterable(
      maps,
      key: (item) => item['key'] as String,
      value: (item) => item['value'] as String,
    );
  }

  Future<void> clearPreferences() async {
    final db = await database;
    await db.delete('preferences');
  }
}
