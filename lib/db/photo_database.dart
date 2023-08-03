import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../views/prescription/photo.dart';

class DatabaseAlreadyOpenException implements Exception {}

class DirectoryException implements Exception {}

class DbNotOpen implements Exception {}

class UserAlreadyExists implements Exception {}

class CouldNotFindUser implements Exception {}

class DbHelper {
  static Database? _db;
  static const String id = 'id';
  static const String name = 'name';
  static const String tableName = 'photoTable';
  static const String dbName = 'photos.db';
  // Future<Database> get db async {
  //   if (_db != null) {
  //     return _db!;
  //   }
  //   _db = await initDB();
  //   return _db!;
  // }

  // Future<Database> initDB() async {
  //   final docsPath = await getApplicationDocumentsDirectory();
  //   final path = join(docsPath.path, 'Profile_view.db');
  //   final db = await openDatabase(path, version: 1, onCreate: _onCreate);
  //   return db;
  // }

  // _onCreate(Database db, int version) async {
  //   await db.execute('CREATE TABLE $tableName($id INTEGER, $name TEXT)');
  // }
  static final DbHelper _shared = DbHelper._sharedInstance(); //Singleton object
  DbHelper._sharedInstance();
  factory DbHelper() => _shared;
  Future<Photo> save(Photo photo) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseorThrow();
    photo.id = await db.insert(tableName, photo.toMap());
    return photo;
  }

  Future<List<Photo>> getPhotos() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseorThrow();
    List<Map<String, dynamic>> map =
        await db.query(tableName, columns: [id, name]);
    List<Photo> photo = [];
    if (map.isNotEmpty) {
      for (int i = 0; i < map.length; i++) {
        photo.add(Photo.fromMap(map[i]));
      }
    }
    return photo;
  }

  Future<void> open() async {
    if (_db != null) {
      throw DatabaseAlreadyOpenException();
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final path = join(docsPath.path, 'photos.db');
      final db = await openDatabase(path);
      _db = db;
      db.execute('CREATE TABLE $tableName($id INTEGER, $name TEXT)');
    } on MissingPlatformDirectoryException {
      throw DirectoryException();
    }
  }

  Future<void> _ensureDbIsOpen() async {
    try {
      await open();
    } on DatabaseAlreadyOpenException {}
  }

  Database _getDatabaseorThrow() {
    final db = _db;
    if (db == null) {
      throw DbNotOpen();
    } else {
      return db;
    }
  }

  Future<void> close() async {
    final db = _db;
    if (db == null) {
      throw DbNotOpen();
    } else {
      await db.close();
    }
  }
}
