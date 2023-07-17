import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAlreadyOpenException implements Exception {}

class DirectoryException implements Exception {}

class DbNotOpen implements Exception {}

class UserAlreadyExists implements Exception {}

class CouldNotFindUser implements Exception {}

class SQLHelper {
  Database? _db;

  static final SQLHelper _shared = SQLHelper._sharedInstance();
  SQLHelper._sharedInstance();
  factory SQLHelper() => _shared;

  Future<DatabaseUser> getOrCreateUser({required String email}) async {
    try {
      final user = await getUser(email: email);
      return user;
    } on CouldNotFindUser {
      final createdUser = await createUser(
        name: '',
        email: '',
        aadhar_no: '',
        gender: '',
        phone1: '',
        phone2: '',
        profession: '',
        address1: '',
        dateofbirth: '',
        district: '',
        address2: '',
        pincode: '',
        wardNo: '',
      );
      return createdUser;
    } catch (e) {
      rethrow;
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

  Future<void> open() async {
    if (_db != null) {
      throw DatabaseAlreadyOpenException();
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final path = join(docsPath.path, 'Profile_view.db');
      final db = await openDatabase(path);
      _db = db;
      db.execute(createTable);
    } on MissingPlatformDirectoryException {
      throw DirectoryException();
    }
  }

  Future<DatabaseUser> createUser({
    required String name,
    required String email,
    required String aadhar_no,
    required String gender,
    required String phone1,
    required String phone2,
    required String profession,
    required String address1,
    required String district,
    required String dateofbirth,
    required String address2,
    required String pincode,
    required String wardNo,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseorThrow();

    int userId = await db.insert('complaint', {
      nameColumn: name,
      emailColumn: email,
      aadhar_noColumn: aadhar_no,
      genderColumn: gender,
      phone1Column: phone1,
      phone2Column: phone2,
      professionColumn: profession,
      address1Column: address1,
      dateofbirthColumn: dateofbirth,
      districtColumn: district,
      address2Column: address2,
      pincodeColumn: pincode,
      wardNoColumn: wardNo,
    });
    return DatabaseUser(
      id: userId,
      name: name,
      email: email,
      aadhar_no: aadhar_no,
      gender: gender,
      phone1: phone1,
      phone2: phone2,
      profession: profession,
      address1: address1,
      dateofbirth: dateofbirth,
      district: district,
      address2: address2,
      pincode: pincode,
      wardNo: wardNo,
    );
  }

  Future<DatabaseUser> getUser({required String email}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseorThrow();
    final results = await db
        .query('complaint', limit: 1, where: 'email=?', whereArgs: [email]);
    if (results.isEmpty) {
      throw CouldNotFindUser();
    } else {
      return DatabaseUser.fromRow(results.first);
    }
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseorThrow();
    return await db.query('complaint', orderBy: "id");
  }

  Future<int> updateItem({
    required String name,
    required String email,
    required String aadhar_no,
    required String gender,
    required String phone1,
    required String phone2,
    required String profession,
    required String address1,
    required String district,
    required String dateofbirth,
    required String address2,
    required String pincode,
    required String wardNo,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseorThrow();
    final data = {
      'name': name,
      'email': email,
      'aadhar_no': aadhar_no,
      'gender': gender,
      'phone1': phone1,
      'phone2': phone2,
      'profession': profession,
      'address1': address1,
      'district': district,
      'dateofbirth': dateofbirth,
      'address2': address2,
      'pincode': pincode,
      'wardNo': wardNo,
    };
    final result = await db
        .update('complaint', data, where: 'email=?', whereArgs: [email]);
    return result;
  }

  Future<void> deleteItem({required int id}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseorThrow();
    try {
      await db.delete("complaint", where: "id=?", whereArgs: [id]);
    } catch (e) {
      print("Someting went W while deleting:$e");
    }
  }
}

@immutable
class DatabaseUser {
  final int id;
  final String name;
  final String email;
  final String aadhar_no;
  final String gender;
  final String phone1;
  final String phone2;
  final String profession;
  final String address1;
  final String district;
  final String address2;
  final String pincode;
  final String wardNo;

  final String dateofbirth;

  const DatabaseUser({
    required this.gender,
    required this.address2,
    required this.pincode,
    required this.wardNo,
    required this.id,
    required this.name,
    required this.email,
    required this.aadhar_no,
    required this.profession,
    required this.address1,
    required this.district,
    required this.phone1,
    required this.phone2,
    required this.dateofbirth,
  });
  DatabaseUser.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        name = map[nameColumn] as String,
        email = map[emailColumn] as String,
        aadhar_no = map[aadhar_noColumn] as String,
        gender = map[genderColumn] as String,
        phone1 = map[phone1Column] as String,
        phone2 = map[phone2Column] as String,
        profession = map[professionColumn] as String,
        address1 = map[address1Column] as String,
        district = map[districtColumn] as String,
        dateofbirth = map[dateofbirthColumn] as String,
        address2 = map[address2Column] as String,
        pincode = map[pincodeColumn] as String,
        wardNo = map[wardNoColumn] as String;
}

const idColumn = 'id';
const nameColumn = 'name';
const emailColumn = 'email';
const aadhar_noColumn = 'aadhar_no';

const genderColumn = 'gender';
const phone1Column = 'phone1';
const phone2Column = 'phone2';
const professionColumn = 'profession';
const address1Column = 'address1';
const districtColumn = 'district';
const dateofbirthColumn = 'dateofbirth';

const address2Column = 'address2';
const pincodeColumn = 'pincode';
const wardNoColumn = 'wardNo';
const createTable = """CREATE TABLE "complaint" (
	"id"	INTEGER NOT NULL UNIQUE,
 	"name"	TEXT ,
   "email"	TEXT,
 	"aadhar_no"	TEXT,
  "gender" TEXT,
   "phone1"	TEXT,
 	"phone2"	TEXT,
  "profession" TEXT,
   "address1"	TEXT,
 	"district"	TEXT,
  "dateofbirth"	TEXT, 	
  "address2" TEXT,
  "pincode" TEXT,
  "wardNo" TEXT,  
   PRIMARY KEY("id" AUTOINCREMENT)
 );
  """;
