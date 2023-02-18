import 'dart:developer';
import 'package:news_app/Models/news_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static DbHelper dbHelper = DbHelper();
  DbHelper() {
    initDatabase();
  }
  //table name
  static const String tableName = 'newsTable';
  //table columns
  static const String newsId = 'id';
  static const String newsTitle = 'title';
  static const String newsImage = 'image';
  static const String newsPublishedAt = 'publishedAt';
  static const String newsUrl = 'url';

  Database? database;

  initDatabase() async {
    database = await createConnectionWithDatabase();
  }

  //Create Connection
  Future<Database> createConnectionWithDatabase() async {
    log("on createConnectionWithDatabase");
    String databasePath = await getDatabasesPath();
    String databaseName = 'GlobalNewsDatabase';
    String fullPath = join(databasePath, databaseName);
    //Create and Open Database
    Database database =
        await openDatabase(fullPath, version: 1, onCreate: (db, i) async {
      log("in onCreate");
      await db.execute('''
        CREATE TABLE $tableName (
        $newsId TEXT PRIMARY KEY ,
        $newsTitle TEXT,
        $newsImage TEXT,
        $newsPublishedAt TEXT,
        $newsUrl TEXT
        )
      ''');
      log('DataBase Created');
    }, onOpen: (db) {
      log('DataBase Opened');
    });
    return database;
  }

  // insert Favorites News into Database
  insertFavoriteNews(NewsModel newsModel) async {
    await database!.insert(tableName, newsModel.toJsonDB());
  }

  // Select Favorites News From Database
  Future<List<NewsModel>> selectAllFavoriteNews() async {
    List<Map<String, Object?>> rowsAsMap = await database!.query(tableName);
    List<NewsModel> newsDatabase =
        rowsAsMap.map((e) => NewsModel.fromJsonDB(e)).toList();
    return newsDatabase;
  }

  // Delete Favorites News From Database
  deleteOneFavoriteNews(String id) {
    database!.delete(tableName, where: '$newsId=?', whereArgs: [id]);
  }
}
