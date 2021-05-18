import 'package:saskarnote/database/queries/note_query.dart';
import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;
import 'package:saskarnote/models/NoteModel.dart';

class DbHelper {
  static DbHelper _dbHelper = DbHelper._singleton();

  factory DbHelper() {
    return _dbHelper;
  }

  DbHelper._singleton();

  final tables = [
    NoteQuery.CREATE_TABLE,
  ]; // daftar table yang akan dibuat

  Future<Database> openDb() async {
    final dbPath = await sqlite.getDatabasesPath();

    return sqlite.openDatabase(path.join(dbPath, 'saskarnote.db'),
        onCreate: (db, version) {
      tables.forEach((table) async {
        await db.execute(table).then((value) {
          print("berhasil ");
        }).catchError((err) {
          print("errornya ${err.toString()}");
        });
      });
      print('Table Created');
    }, version: 1);
  }

  insert(String table, Map<String, Object> data) {
    openDb().then((db) {
      db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
    }).catchError((err) {
      print("error $err");
    });
  }

  Future<List> getAll(String tableName) async {
    final db = await openDb();
    var result = await db.query(tableName, orderBy: 'id DESC');
    return result.toList();
  }

  Future<List> getWhere(String tableName, String key, String value) async {
    final db = await openDb();
    var result = await db.query(
      tableName,
      columns: ['id', 'judul', 'catatan', 'tanggal'],
      where: '$key = ?',
      whereArgs: [value],
    );
    return result.toList();
  }

  update(String tableName, int id, Map<String, dynamic> row) async {
    final db = await openDb();
    return await db.update(tableName, row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(String tableName, int id) async {
    final db = await openDb();
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
