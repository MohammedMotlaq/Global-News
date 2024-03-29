
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:news_app/AppRouter.dart';
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

  String getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }

  //Get Popular News From API
  Future<List<NewsModel>> getAllNews() async {
    Response responseAll = await dio.get(
        'https://newsapi.org/v2/everything?q=every&from=$getCurrentDate()&sortBy=popularity&apiKey=52b32334576e4faea5835dd2640a4841');
    List responseListAll = responseAll.data['articles'];
    List<NewsModel> allNews = responseListAll.map((e) {
      return NewsModel.fromJson(e);
    }).toList();
    return allNews;
  }

  //Get Discover News From API
  getDiscoverNews(String discover) async {
    Response responseDiscover = await dio.get(
        'https://newsapi.org/v2/everything?q=$discover&from=$getCurrentDate()&sortBy=popularity&apiKey=52b32334576e4faea5835dd2640a4841');
    List responseListDis = responseDiscover.data['articles'];
    List<NewsModel> discoverList = responseListDis.map((e) {
      return NewsModel.fromJson(e);
    }).toList();
    return discoverList;
  }

  //Get Search Result News From API
  getSearchNews(String searchTitle) async {

    bool isConnected = await InternetConnectionChecker().hasConnection;

    if (isConnected) {
      try {
        Response responseSearch = await dio.get(
            'https://newsapi.org/v2/everything?q=$searchTitle&apiKey=52b32334576e4faea5835dd2640a4841');
        List responseListSearch = responseSearch.data['articles'];
        List<NewsModel> searchList = responseListSearch.map((e) {
          return NewsModel.fromJson(e);
        }).toList();
        return searchList;
      } catch (e) {
        log(e.toString());
      }
    } else {
      AppRouter.showErrorSnackBar("No Internet", "Please check your Internet Connection");
    }
  }
}
