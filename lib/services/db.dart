import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initDb() async {
  return openDatabase(
    join(await getDatabasesPath(), 'database.db'),
    onCreate: (db,version){
      return db.execute(
        "CREATE TABLE files(id INTEGER PRIMARY KEY, name TEXT)",
      );
    },
    version: 1,
  );

}
