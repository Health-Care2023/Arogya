import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();
  static Database? _database;

  final String tableName = 'patients';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnEmail = 'email';
  final String columnAadharNo = 'aadhar_no';
  final String columnGender = 'gender';
  final String columnProfession = 'profession';
  final String columnAddress1 = 'address1';
  final String columnAddress2 = 'address2';
  final String columnAddress3 = 'address3';
  final String columnDistrict = 'District';
  final String columnPincode = 'Pincode';
  final String columnWordno = 'WordNo';
  final String columnPhone1 = 'Phone1';
  final String columnPhone2 = 'Phone2';
  final String columnDob = 'dateOfbirth';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDatabase();
    return _database!;
  }

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
        $columnPhone1 TEXT,
        $columnPhone2 TEXT,
        $columnDob TEXT,
        $columnAadharNo TEXT,
        $columnGender TEXT,
        $columnProfession TEXT,
        $columnAddress1 TEXT,
        $columnAddress2 TEXT,
        $columnAddress3 TEXT,
        $columnWordno TEXT,
        $columnPincode TEXT,
        $columnDistrict TEXT,
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
      where: '$columnEmail = ?',
      whereArgs: [patient[columnEmail]],
    );
    return updatedCount;
  }
}
