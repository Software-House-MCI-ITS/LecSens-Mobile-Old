import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:lecsens/models/access_model.dart';
import 'package:lecsens/models/alat_model.dart';
import 'package:lecsens/models/lecsens_data_model.dart';
import 'package:lecsens/models/role_model.dart';
import 'package:lecsens/models/user_data_model.dart';
import 'package:lecsens/models/user_model.dart';

import 'dart:developer' as developer;

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
      developer.log('Database path: $path');

      return await openDatabase(path, version: 1, onCreate: _createDB);
    } catch (ex) {
      throw Exception("Error in initiating database");
    }
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
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
        ${UserFields.roleID} $textType
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

    await db.insert(tableRoles, Role(id: 1, name: 'admin').toJson());
    await db.insert(tableRoles, Role(id: 2, name: 'user').toJson());

    await db.insert(tableUsers, User(
      id: 1,
      userName: 'admin',
      email: 'adminadmin123@gmail.com',
      fullName: 'Admin Admin',
      isVerified: true,
      lastLoginTimestamp: '2021-10-10 10:10:10',
      roleID: 1,
    ).toJson());

    await db.insert(tableUsers, User(
      id: 2,
      userName: 'user',
      email: 'useruser123@gmail.com',
      fullName: 'User User',
      isVerified: true,
      lastLoginTimestamp: '2021-10-10 10:10:10',
      roleID: 2,
    ).toJson());

    await db.insert(tableAlat, Alat(
      id: 1,
      macAddress: '00:00:00:00:00:00',
      mode: 1,
      namaAlat: 'alat',
      owner: 'owner',
      pwm: 'pwm',
      status: 1,
    ).toJson());

    await db.insert(tableAccess, Access(
      id: 1,
      userID: 1,
      alatID: 1,
    ).toJson());

    await db.insert(tableUserData, UserData(
      id: 1,
      gender: true,
      jabatan: 'jabatan',
    ).toJson());

    await db.insert(tableLecsensData, LecsensData(
      id: 1,
      alatID: 1,
      userID: 1,
      lokasi: 'lokasi',
      epc: 1.0,
      ipc: 1.0,
      ipa: 1.0,
      epa: 1.0,
      predictionA: 1.0,
      predictionB: 1.0,
      predictionC: 1.0,
      predictionD: 1.0,
      predictionE: 1.0,
      predictionF: 1.0,
      predictionG: 1.0,
    ).toJson());
  }
}
