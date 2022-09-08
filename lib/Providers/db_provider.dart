import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:news_app/Helpers/database_helper.dart';
import 'package:news_app/Models/news_model.dart';

class DbProvider extends ChangeNotifier {
  DbProvider() {
    selectAllNews();
    notifyListeners();
  }
  List<NewsModel> favoritesNews = [];

  selectAllNews() async {
    favoritesNews = await DbHelper.dbHelper.selectAllFavoriteNews();
    log(favoritesNews.length.toString());
    notifyListeners();
  }

  insertFavoriteNews(NewsModel favoriteModel) async {
    await DbHelper.dbHelper.insertFavoriteNews(favoriteModel);
    selectAllNews();
  }

  deleteNews(String id) async {
    await DbHelper.dbHelper.deleteOneFavoriteNews(id);
    selectAllNews();
  }

}
