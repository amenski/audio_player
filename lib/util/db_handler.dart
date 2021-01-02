import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'constants.dart';

class DatabaseHandler {
  DatabaseHandler._internal(); //private constructor, could also be DatabaseHandler._();
  static final _instance = DatabaseHandler._internal();

  factory DatabaseHandler() => _instance;

  static Database _database;

  Future<Database> get getDatabase async {
    if (_database == null) {
      _database = await initDb();
    }

    return _database;
  }

  initDb() async {
    //Sqflite.devSetDebugModeOn(true);
    Directory appDocDir;
    var path;

    appDocDir = await getApplicationDocumentsDirectory();
    if(appDocDir != null) {
      path = join(appDocDir.path, Constants.DATABASE_FILE_NAME);
    }
    
    // Return if the database already exist
    // https://github.com/tekartik/sqflite/blob/master/sqflite/doc/opening_asset_db.md
    if(path != null && (FileSystemEntity.typeSync(path) == FileSystemEntityType.file))
      return await openDatabase(path);
    
    // If does not exist, copy from assets folder
    ByteData data = await rootBundle.load(join('assets/data', Constants.DATABASE_FILE_NAME));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Save copied asset to documents
    File(path).writeAsBytes(bytes);
    return await openDatabase(path);
  }
}
