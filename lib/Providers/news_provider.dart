import 'package:flutter/material.dart';
import 'package:news_app/Helpers/dio_helper.dart';
import 'dart:developer';
import 'package:news_app/Models/news_model.dart';

class NewsProvider extends ChangeNotifier {
  NewsProvider() {
    getBreakingNews();
    getAllNews();
  }

  List<NewsModel> breakingNews = []; //breaking news
  List<NewsModel> popularNews = []; //popular news
  List<NewsModel> discoverNews = []; //discover news
  List<NewsModel> searchNews = []; //search news

  String selectNews = '';
  selectDisNews(String newsName) {
    selectNews = newsName;
    discoverNews = [];
    notifyListeners();
    getDiscoverNews();
  }

  String searchTitle = '';
  searchTitleNews(String title) {
    searchTitle = title;
    searchNews = [];
    notifyListeners();
    getSearchNews();
  }

  getBreakingNews() async {
    breakingNews = await DioHelper.dioHelper.getBreakingNews();
    log(breakingNews.length.toString());
    notifyListeners();
  }

  getAllNews() async {
    popularNews = await DioHelper.dioHelper.getAllNews();
    log(popularNews.length.toString());
    notifyListeners();
  }

  getDiscoverNews() async {
    discoverNews = await DioHelper.dioHelper.getDiscoverNews(selectNews);
    log(discoverNews.length.toString());
    notifyListeners();
  }

  getSearchNews() async {
    searchNews = await DioHelper.dioHelper.getSearchNews(searchTitle);
    log(searchNews.length.toString());
    notifyListeners();
  }
}