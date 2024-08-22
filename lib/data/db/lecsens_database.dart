import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:lecsens/models/access_model.dart';
import 'package:lecsens/models/alat_model.dart';
import 'package:lecsens/models/lecsens_data_model.dart';
import 'package:lecsens/models/role_model.dart';
import 'package:lecsens/models/user_data_model.dart';
import 'package:lecsens/models/user_model.dart';

class LecSensDatabase {
  static final LecSensDatabase instance = LecSensDatabase._init();
  static Database? _database;
  LecSensDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('lecsens_trial.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);
      print('Database path: $path');

      return await openDatabase(path, version: 1, onCreate: _createDB);
    } catch (ex) {
      throw Exception("Error in initiating database");
    }
  }

  Future _createDB(Database db, int version) async {
    const idType = 'VARCHAR(36) PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const booleanType = 'BOOLEAN NOT NULL';
    const realType = 'REAL NOT NULL';

    await db.execute('''
      CREATE TABLE $tableUsers (
        ${UserFields.id} $idType,
        ${UserFields.userName} $textType,
        ${UserFields.email} $textType,
        ${UserFields.fullName} $textType,
        ${UserFields.isVerified} $textType,
        ${UserFields.lastLoginTimestamp} $textType,
        ${UserFields.role} $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableRoles (
        ${RoleFields.id} $idType,
        ${RoleFields.name} $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableAccess (
        ${AccessFields.id} $idType,
        ${AccessFields.userID} $textType,
        ${AccessFields.alatID} $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableAlat (
        ${AlatFields.id} $idType,
        ${AlatFields.macAddress} $textType,
        ${AlatFields.mode} $textType,
        ${AlatFields.namaAlat} $textType,
        ${AlatFields.owner} $textType,
        ${AlatFields.pwm} $textType,
        ${AlatFields.status} $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableLecsensData (
        ${LecsensDataFields.id} $idType,
        ${LecsensDataFields.alatID} $textType,
        ${LecsensDataFields.userID} $textType,
        ${LecsensDataFields.lokasi} $textType,
        ${LecsensDataFields.epc} $realType,
        ${LecsensDataFields.ipc} $realType,
        ${LecsensDataFields.ipa} $realType,
        ${LecsensDataFields.epa} $realType,
        ${LecsensDataFields.predictionA} $realType,
        ${LecsensDataFields.predictionB} $realType,
        ${LecsensDataFields.predictionC} $realType,
        ${LecsensDataFields.predictionD} $realType,
        ${LecsensDataFields.predictionE} $realType,
        ${LecsensDataFields.predictionF} $realType,
        ${LecsensDataFields.predictionG} $realType
      )
    ''');

    print('Database created');
  }
}
