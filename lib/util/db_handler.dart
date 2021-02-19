import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  DatabaseHandler._internal(); //private constructor, could also be DatabaseHandler._();
  static final _instance = DatabaseHandler._internal();

  factory DatabaseHandler() => _instance;

  static Database _database;

  Future<Database> get getDatabase async {
    if (_database != null) return _database;

    return await initDb();
  }

  initDb() async {
    try {
      //Sqflite.devSetDebugModeOn(true);
      // String path;
      //
      // Directory appDocDir = await getApplicationDocumentsDirectory();
      // //if (appDocDir != null) {
      //   path = join(appDocDir.path, Constants.DATABASE_FILE_NAME);
      // //}
      //
      // // Return if the database already exist
      // // https://github.com/tekartik/sqflite/blob/master/sqflite/doc/opening_asset_db.md
      // if (path != null && (FileSystemEntity.typeSync(path) == FileSystemEntityType.file))
      //   return await openDatabase(path);
      //
      // // If does not exist, copy from assets folder
      // ByteData data = await rootBundle.load(join('assets/data', Constants.DATABASE_FILE_NAME));
      // List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      //
      // // Save copied asset to documents
      // File(path).writeAsBytes(bytes);
      // return await openDatabase(path);
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, "audio_be_database.db");
      return await openDatabase(path, version: 1, onOpen: (db) {
      }, onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE category ("
            "id	INTEGER PRIMARY KEY AUTOINCREMENT,"
            "title	TEXT NOT NULL,"
            "description	TEXT,"
            "parent_category_id	INTEGER,"
            "thumb_url TEXT,"
            "external_id TEXT not null"
            ")");
        await db.execute("CREATE TABLE post ("
            "id	INTEGER,"
            "category_id	INTEGER NOT NULL,"
            "title	TEXT NOT NULL,"
            "url	TEXT NOT NULL,"
            "thumb_url TEXT,"
            "description	TEXT,"
            "download_path TEXT,"
            "is_downloaded	INTEGER NOT NULL DEFAULT 0,"
            "is_opened	INTEGER NOT NULL DEFAULT 0,"
            "PRIMARY KEY (id, category_id)"
            ")");

        await db.execute("CREATE TABLE version ("
            "id	INTEGER,"
            "version INTEGER not null"
            ")");

        await db.execute("INSERT INTO android_metadata('locale') VALUES('en_US')");
        await db.execute("INSERT INTO version(id, version) values(1,0)");
      });

    } catch(e){print(e);}
  }
}
