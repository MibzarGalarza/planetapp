import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DataHelper {
  static Future<Database> datebae() async {
    final datapath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(datapath, 'image.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_image(id TEXT PRIMARY KEY, title TEXT, image TEXT, size TEXT,des TEXT, distance TEXT, selectedType TEXT, natureType TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DataHelper.datebae();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DataHelper.datebae();
    return db.query(table);
  }
}
