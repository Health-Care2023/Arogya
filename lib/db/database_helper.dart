import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  final String tableName = 'patients';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnEmail = 'email';
  final String columnAadharNo = 'aadhar_no';
  final String columnGender = 'gender';
  final String columnPhone1 = 'phone1';
  final String columnPhone2 = 'phone2';
  final String columnProfession = 'profession';
  final String columnAddress1 = 'address1';
  final String columnAddress2 = 'address2';
  final String columnAddress3 = 'address3';
  final String columnDistrict = 'district';
  final String columnPincode = 'pincode';
  final String columnWordno = 'wordno';
  final String columnDob = 'dateofbirth';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDatabase();
    return _database!;
  }

  DatabaseHelper.internal();

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'patients.db');
    var database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT,
        $columnEmail TEXT,
        $columnAadharNo TEXT,
        $columnGender TEXT,
        $columnPhone1 TEXT,
        $columnPhone2 TEXT,
        $columnProfession TEXT,
        $columnAddress1 TEXT,
        $columnAddress2 TEXT,
        $columnAddress3 TEXT,
        $columnDistrict TEXT,
        $columnPincode TEXT,
        $columnWordno TEXT,
        $columnDob TEXT
      )
    ''');
  }

  Future<int> insertPatient(Map<String, dynamic> patient) async {
    Database db = await database;
    int id = await db.insert(tableName, patient);
    return id;
  }

  Future<Map<String, dynamic>?> getPatientByEmail(String email) async {
    Database db = await database;
    List<Map<String, dynamic>> patients = await db.query(
      tableName,
      where: '$columnEmail = ?',
      whereArgs: [email],
    );
    if (patients.isNotEmpty) {
      return patients.first;
    } else {
      return null;
    }
  }

  Future<int> updatePatient(Map<String, dynamic> patient) async {
    Database db = await database;
    int updatedCount = await db.update(
      tableName,
      patient,
      where: '$columnId = ?',
      whereArgs: [patient[columnId]],
    );
    return updatedCount;
  }
}
