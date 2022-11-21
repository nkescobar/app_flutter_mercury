import 'dart:async';

import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';

class AppDatabase {
  static AppDatabase? _singleton;
  Database? _db;

  factory AppDatabase() {
    _singleton ??= AppDatabase._();
    return _singleton!;
  }

  AppDatabase._();

  Future<Database> _setupDataBase(String dbName) async {
    var appDocDirectory = await getApplicationDocumentsDirectory();
    var dbPath = '${appDocDirectory.path}/$dbName.db';
    var dbFactory = databaseFactoryIo;
    return await dbFactory.openDatabase(dbPath);
  }

  Database? get myDatabase {
    return _db;
  }

  Future<Database> get database async {
    _db ??= await _setupDataBase('mercury_db');
    return (_db as Database);
  }

  Future deleteDatabase() async {
    var appDocDirectory = await getApplicationDocumentsDirectory();
    await databaseFactoryIo
        .deleteDatabase('${appDocDirectory.path}/mercury_db.db');
    _db = null;
  }
}
