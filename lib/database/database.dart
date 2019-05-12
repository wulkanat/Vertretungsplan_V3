import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ScheduleDatabase {
  static const DATABASE_NAME = "schedule.db";
  static const TABLE_NAME = "day";
  static const COL_1 = 'kl';
  static const COL_2 = 'std';
  static const COL_3 = 'fach';
  static const COL_4 = 'raum';
  static const COL_5 = 'vlehrer';
  static const COL_6 = 'vfach';
  static const COL_7 = 'vraum';
  static const COL_8 = 'info';

  String path = '';
  Database database;
  
  configure() async {
    this.path = join(await getDatabasesPath(), 'schedule.db');
    this.database = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await _createTable(db, 0);
    });
  }

  _createTable(Database db, int table) async {
    await db.execute('create table if not exists $TABLE_NAME$table(ID INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$COL_1 TEXT, '
        '$COL_2 TEXT, '
        '$COL_3 TEXT, '
        '$COL_4 TEXT, '
        '$COL_5 TEXT, '
        '$COL_6 TEXT, '
        '$COL_7 TEXT, '
        '$COL_8 TEXT)');
  }

  deleteTable(int table) async {
    await database.execute('drop table if exists $TABLE_NAME$table');
  }

  insertData(int table, String kl, String std, String fach, String raum, String vlehrer, String vfach, String vraum, String info) async {
    // make sure we don't write in a non-existing database
    await _createTable(database, table);
    // insert data
    await database.insert('$TABLE_NAME$table', {
      COL_1: kl,
      COL_2: std,
      COL_3: fach,
      COL_4: raum,
      COL_5: vlehrer,
      COL_6: vfach,
      COL_7: vraum,
      COL_8: info
    });
  }
}