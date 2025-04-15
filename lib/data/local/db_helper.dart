import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();
  static final DbHelper getInstance = DbHelper._();

  static final String Table_Note = "note";
  static final String Column_Note_SNO = 'sno';
  static final String Column_Note_Title = 'title';
  static final String Column_Note_Description = 'description';

  Database? myDB;

  Future<Database> getDB() async {
    myDB ??= await openDB();
    return myDB!;
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbpath = join(appDir.path, "noteDB.db");
    return await openDatabase(
      dbpath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE $Table_Note ( $Column_Note_SNO INTEGER PRIMARY KEY AUTOINCREMENT, $Column_Note_Title TEXT, $Column_Note_Description TEXT)",
        );
      },
    );
  }

  Future<bool> addNote({
    required String mTitle,
    required String mDescription,
    int? sno,
  }) async {
    var db = await getDB();
    int rowsEffected = await db.insert(Table_Note, {
      Column_Note_Title: mTitle,
      Column_Note_Description: mDescription,
    });
    return rowsEffected > 0;
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getDB();
    List<Map<String, dynamic>> mData = await db.query(Table_Note);
    return mData;
  }

  Future<bool> updateNote({
    required String mTitle,
    required String mDescription,
    required int sno,
  }) async {
    var db = await getDB();
    int rowsEffected = await db.update(Table_Note, {
      Column_Note_Title: mTitle,
      Column_Note_Description: mDescription,
    }, where: "$Column_Note_SNO = $sno");
    return rowsEffected > 0;
  }

  Future<bool> deleteNote({required int sno}) async {
    var db = await getDB();
    int rowsEfffected = await db.delete(
      Table_Note,
      where: "$Column_Note_SNO = ?",
      whereArgs: [sno],
    );
    return rowsEfffected > 0;
  }
}
