import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Databases {

  static Database? db ;


  /// Initialing & create tables if not created.
  static Future<Database> initialDatabases () async {
    if (db != null){
      return db!;
    }
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'sensifai.db');
    db = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      // await db.execute('CREATE TABLE Images (id INTEGER PRIMARY KEY, image_id TEXT, album_id TEXT, name TEXT, path TEXT, thumbnail TEXT, is_tagged INTEGER, labels TEXT, like BOOLEAN, location TEXT, newest TEXT, faces TEXT)');
      // await db.execute('CREATE TABLE Faces (id INTEGER PRIMARY KEY, name TEXT, faces TEXT, face TEXT)');
      await db.execute('CREATE TABLE Labels (id INTEGER PRIMARY KEY, name TEXT, path TEXT, labels TEXT, medium TEXT, persons TEXT, location TEXT, city TEXT, faces TEXT, faces_details TEXT, recognised BOOLEAN)');
      await db.execute('CREATE TABLE Likes (id INTEGER PRIMARY KEY, name TEXT, path TEXT, medium TEXT)');
      await db.execute('CREATE TABLE Faces (id INTEGER PRIMARY KEY, name TEXT, faces TEXT, face TEXT)');
    });
    return db! ;
  }

  static Future<int> getCountFromTable(String table, {String suffix = "", mainThread = true}) async {
    if (!mainThread){
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'sensifai.db');
      db = await openDatabase(path, version: 1);
    }
    var count = await runQuery("SELECT COUNT(id) FROM $table $suffix");
    if (count == null) return 0 ;
    return int.parse(count[0]['COUNT(id)'].toString()) ;
  }

  static Future<List<Map<String, Object?>>?> getAlbums({mainThread = true}) async {
    if (!mainThread){
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'sensifai.db');
      db = await openDatabase(path, version: 1);
    }
    return await runQuery("SELECT * FROM Albums");
  }

  static Future<List<Map<String, Object?>>?> runQuery(String query, {mainThread = true}) async {
    if (!mainThread){
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'sensifai.db');
      db = await openDatabase(path, version: 1);
    }
    if (!query.contains("SELECT")){
      return null;
    }
    return await db?.rawQuery(query);
  }

  static Future<int?> modify(String query, {mainThread = true}) async {
    if (!mainThread){
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'sensifai.db');
      db = await openDatabase(path, version: 1);
    }
    if (query.startsWith("DELETE")){
      return await db?.rawDelete(query);
    } else if (query.startsWith("UPDATE")){
      return await db?.rawUpdate(query);
    } else if (query.startsWith("INSERT")){
      return await db?.rawInsert(query);
    } else {
      return null;
    }
  }

  static Future<dynamic> getAlbum(String id) async {
    var album = await runQuery("SELECT * FROM Albums WHERE album_id = $id");
    print(album);
  }

}