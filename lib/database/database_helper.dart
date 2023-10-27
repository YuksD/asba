import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await openDatabase(
      'my_database.db', // Veritabanı adı
      version: 1, // Veritabanı sürümü
      onCreate: _createDatabase,
    );
    return _database!;
  }

  void _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE call_details(
        callerName TEXT,
        callerNumber TEXT
      )
    ''');
  }

  Future<void> saveCallDetails(String callerName, String callerNumber) async {
    final db = await database;
    await db.insert('call_details', {
      'callerName': callerName,
      'callerNumber': callerNumber,
    });
  }

  Future<List<Map<String, dynamic>>> getCallDetails() async {
    final db = await database;
    return db.query('call_details');
  }
}
