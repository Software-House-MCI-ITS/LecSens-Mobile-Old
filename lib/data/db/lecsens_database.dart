import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:lecsens/models/alat_model.dart';
import 'package:lecsens/models/lecsens_data_model.dart';
import 'package:lecsens/models/user_model.dart';

class LecSensDatabase {
  static final LecSensDatabase instance = LecSensDatabase._init();
  static Database? _database;
  LecSensDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('lecsens_trial14.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);

      return await openDatabase(path, version: 1, onCreate: _createDB);
    } catch (ex) {
      throw Exception("Error in initiating database" + ex.toString());
    }
  }

  Future _createDB(Database db, int version) async {
    const idType = 'VARCHAR(36) PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const booleanType = 'BOOLEAN NOT NULL';
    const realType = 'REAL NOT NULL';
    const timestampType = 'TIMESTAMP NOT NULL';

    await db.execute('''
      CREATE TABLE $tableAlat (
        ${AlatFields.id} $idType,
        ${AlatFields.userID} $textType,
        ${AlatFields.alatID} $textType,
        ${AlatFields.role} $textType,
        ${AlatFields.owner} $textType,
        ${AlatFields.namaAlat} $textType,
        ${AlatFields.status} $integerType,
        ${AlatFields.pwm} $textType,
        ${AlatFields.mode} $integerType,
        ${AlatFields.macAddress} $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableLecsensData (
        ${LecsensDataFields.id} $idType,
        ${LecsensDataFields.alatID} $textType,
        ${LecsensDataFields.alamat} $textType,
        ${LecsensDataFields.data_x} $textType,
        ${LecsensDataFields.data_y} $textType,
        ${LecsensDataFields.user_id} $textType,
        ${LecsensDataFields.epc} $integerType,
        ${LecsensDataFields.ipc} $integerType,
        ${LecsensDataFields.ipa} $integerType,
        ${LecsensDataFields.epa} $integerType,
        ${LecsensDataFields.peak_x} $realType,
        ${LecsensDataFields.peak_y} $realType,
        ${LecsensDataFields.ppm} $realType,
        ${LecsensDataFields.label} $textType,
        ${LecsensDataFields.createdAt} $timestampType
      )
    ''');
  }

  Future<void> bulkInsertAlat(List<Alat> alatList) async {
    try {
      final db = await instance.database;
      final batch = db.batch();

      for (var alat in alatList) {
        batch.insert(tableAlat, alat.toJson());
      }

      await batch.commit(noResult: true);
    } catch (ex) {
      throw Exception("Error in creating alat" + ex.toString());
    }
  }

  Future<void> bulkInsertLecsensData(List<LecsensData> lecsensDataList) async {
    try {
      final db = await instance.database;
      final batch = db.batch();

      for (var lecsensData in lecsensDataList) {
        print('data: ${lecsensData.toJson()}');
        try {
          batch.insert(tableLecsensData, lecsensData.toJson());
        } catch (e) {
          print('Error in inserting lecsens data: $e');
        }
      }

      await batch.commit(noResult: true);
    } catch (ex) {
      throw Exception("Error in creating lecsens data" + ex.toString());
    }
  }

  Future<void> bulkUpdateAlat(List<Alat> alatList) async {
    try {
      final db = await instance.database;
      final batch = db.batch();

      for (var alat in alatList) {
        batch.update(tableAlat, alat.toJson(), where: '${AlatFields.id} = ?', whereArgs: [alat.id]);
      }

      await batch.commit(noResult: true);
      print('Updated alat');
      print('Updated alat');
      print('Updated alat');
    } catch (ex) {
      throw Exception("Error in updating alat" + ex.toString());
    }
  }

  Future<void> bulkUpdateLecsensData(List<LecsensData> lecsensDataList) async {
    try {
      final db = await instance.database;
      final batch = db.batch();

      for (var lecsensData in lecsensDataList) {
        batch.update(tableLecsensData, lecsensData.toJson(), where: '${LecsensDataFields.id} = ?', whereArgs: [lecsensData.id]);
      }

      await batch.commit(noResult: true);
      print('Updated lecsens data');
      print('Updated lecsens data');
      print('Updated lecsens data');
    } catch (ex) {
      throw Exception("Error in updating lecsens data" + ex.toString());
    }
  }

  Future<void> deleteAllAlat() async {
    try {
      final db = await instance.database;
      db.delete(tableAlat);
      print('Deleted all alat');
      print('Deleted all alat');
      print('Deleted all alat');
    } catch (ex) {
      throw Exception("Error in deleting all alat");
    }
  }

  Future<void> deleteAllLecsensData() async {
    try {
      final db = await instance.database;
      db.delete(tableLecsensData);
      print('Deleted all lecsens data');
      print('Deleted all lecsens data');
      print('Deleted all lecsens data');
    } catch (ex) {
      throw Exception("Error in deleting all lecsens data");
    }
  }

  Future<AlatList> getAllAlat(int page) async {
    try {
      final db = await instance.database;
      final result = await db.query(tableAlat, limit: 10, offset: page * 10);

      return AlatList(alatList: result.map((json) => Alat.fromJson(json)).toList());
    } catch (ex) {
      throw Exception("Error in getting all alat" + ex.toString());
    }
  }

  Future<LecsensDataList> getAllLecsensDataByLabelPagination(int page, String label) async {
    try {
      final db = await instance.database;
      final result = await db.query(tableLecsensData, where: '${LecsensDataFields.label} = ?', whereArgs: [label], limit: 10, offset: page * 10);

      return LecsensDataList(lecsensDataList: result.map((json) => LecsensData.fromJson(json)).toList());
    } catch (ex) {
      throw Exception("Error in getting all lecsens data by label" + ex.toString());
    }
  }

  Future<LecsensDataList> getAllLecsensData() async {
    try {
      final db = await instance.database;
      final result = await db.query(tableLecsensData);

      return LecsensDataList(lecsensDataList: result.map((json) => LecsensData.fromJson(json)).toList());
    } catch (ex) {
      throw Exception("Error in getting all lecsens data" + ex.toString());
    }
  }

  Future<LecsensDataList> getAllLecsensDataByDate(String date) async {
    try {
      final db = await instance.database;
      final result = await db.query(tableLecsensData, where: '${LecsensDataFields.createdAt} LIKE ?', whereArgs: ['%$date%'], limit: 5);

      return LecsensDataList(lecsensDataList: result.map((json) => LecsensData.fromJson(json)).toList());
    } catch (ex) {
      throw Exception("Error in getting all lecsens data by date" + ex.toString());
    }
  }
}
