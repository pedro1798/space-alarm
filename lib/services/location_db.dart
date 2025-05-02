import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/stored_location.dart';

class LocationDatabase {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'location.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE locations (
            id TEXT PRIMARY KEY,
            latitude REAL,
            longitude REAL,
            radius REAL
          )
        ''');
      },
    );
    return _database!;
  }

  static Future<void> insertLocation(StoredLocation location) async {
    final db = await database;
    await db.insert(
      'locations',
      location.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<StoredLocation>> getLocations() async {
    final db = await database;
    final maps = await db.query('locations');

    return maps.map((map) => StoredLocation.fromMap(map)).toList();
  }

  static Future<void> deleteLocation(String id) async {
    final db = await database;
    await db.delete('locations', where: 'id = ?', whereArgs: [id]);
  }
}
