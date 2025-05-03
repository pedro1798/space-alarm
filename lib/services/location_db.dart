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
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE locations (
          id TEXT PRIMARY KEY,
          latitude REAL,
          longitude REAL,
          radius REAL,
          name TEXT
        )
      ''');
        // 초기 위치들 삽입 - 앱 최초 실행 시에만
        await _insertInitialLocations(db);
      },
    );
    return _database!;
  }

  /// 초기 위치 데이터 삽입
  static Future<void> _insertInitialLocations(Database db) async {
    final initialLocations = [
      StoredLocation(
        id: 'KNU',
        latitude: 35.889230,
        longitude: 128.612130,
        radius: 100.0,
        name: 'Kyungpook National University',
      ),
      StoredLocation(
        id: 'Mumbai',
        latitude: 19.080699742323194,
        longitude: 72.87755370249461,
        radius: 150.0,
        name: 'Mumbai',
      ),
      StoredLocation(
        id: 'Singapore',
        latitude: 1.359908148594163,
        longitude: 103.83159684467597,
        radius: 150.0,
        name: 'Singapore',
      ),
      StoredLocation(
        id: 'HongKong',
        latitude: 22.33739881289833,
        longitude: 114.16822767232853,
        radius: 150.0,
        name: 'HongKong',
      ),
    ];

    for (final loc in initialLocations) {
      await db.insert(
        'locations',
        loc.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore, // 이미 있으면 무시
      );
    }
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
