import 'dart:developer';
import 'package:news_app/Models/favorite_model.dart';
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

  initDatabase () async{
    database = await createConnectionWithDatabase();
  }

  Future<Database> createConnectionWithDatabase()async {
    log("on createConnectionWithDatabase");
    String databasePath = await getDatabasesPath();
    String databaseName = 'newsDatabase5';
    String fullPath = join(databasePath,databaseName);

    Database database = await openDatabase(fullPath,version: 1,onCreate: (db,i)async{
      log("in onCreate");
      await db.execute('''
        CREATE TABLE $tableName (
        $newsId INTEGER PRIMARY KEY AUTOINCREMENT,
        $newsTitle TEXT,
        $newsImage TEXT,
        $newsPublishedAt TEXT,
        $newsUrl TEXT
        )
      ''');
      log('DataBase Created');
    },onOpen: (db){log('DataBase Opened');});
    return database;
  }

  insertFavoriteNews(FavoriteModel favoriteModel)async{
    int rowIndex = await database!.insert(tableName,favoriteModel.toJson());
    log(rowIndex.toString());
    favoriteModel.id = rowIndex;
  }

  Future<List<FavoriteModel>> selectAllFavoriteNews() async{
    List<Map<String, Object?>> rowsAsMap = await database!.query(tableName);
    List<FavoriteModel> newsDatabase = rowsAsMap.map((e) => FavoriteModel.fromJson(e)).toList();
    return newsDatabase;
  }

  deleteOneFavoriteNews(int id){
    database!.delete(tableName, where: '$newsId=?', whereArgs: [id]);
  }
}