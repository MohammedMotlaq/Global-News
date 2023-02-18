import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:news_app/Models/news_model.dart';

class DioHelper {
  DioHelper._();
  static DioHelper dioHelper = DioHelper._();
  Dio dio = Dio();

  //Get Breaking News From API
  Future<List<NewsModel>> getBreakingNews() async {
    Response responseBreak = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=52b32334576e4faea5835dd2640a4841');
    List responseListBreak = responseBreak.data['articles'];
    List<NewsModel> news = responseListBreak.map((e) {
      return NewsModel.fromJson(e);
    }).toList();
    return news;
  }

  //Get Popular News From API
  Future<List<NewsModel>> getAllNews() async {
    Response responseAll = await dio.get(
        'https://newsapi.org/v2/everything?q=every&from=2023-02-01&sortBy=popularity&apiKey=52b32334576e4faea5835dd2640a4841');
    List responseListAll = responseAll.data['articles'];
    List<NewsModel> allNews = responseListAll.map((e) {
      return NewsModel.fromJson(e);
    }).toList();
    return allNews;
  }

  //Get Discover News From API
  getDiscoverNews(String discover) async {
    Response responseDiscover = await dio.get(
        'https://newsapi.org/v2/everything?q=$discover&from=2023-02-01&sortBy=popularity&apiKey=52b32334576e4faea5835dd2640a4841');
    List responseListDis = responseDiscover.data['articles'];
    List<NewsModel> discoverList = responseListDis.map((e) {
      return NewsModel.fromJson(e);
    }).toList();
    return discoverList;
  }

  //Get Search Result News From API
  getSearchNews(String searchTitle) async {
    Response responseSearch = await dio.get(
        'https://newsapi.org/v2/everything?q=$searchTitle&2023-02-01&sortBy=popularity&apiKey=52b32334576e4faea5835dd2640a4841');
    List responseListSearch = responseSearch.data['articles'];
    List<NewsModel> searchList = responseListSearch.map((e) {
      return NewsModel.fromJson(e);
    }).toList();
    return searchList;
  }
}
