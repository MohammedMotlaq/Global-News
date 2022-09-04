import 'package:flutter/material.dart';
import 'package:news_app/Helpers/dio_helper.dart';
import 'dart:developer';
import '../models/news_model.dart';

class NewsProvider extends ChangeNotifier{
  NewsProvider(){
    getBreakingNews();
    getAllNews();

  }

  List<NewsModel> news=[];
  List<NewsModel> allNews=[];
  List<NewsModel> discoverNews = [];
  List<NewsModel> searchNews = [];

  String selectNews = '';
  selectDisNews(String newsName){
    selectNews = newsName;
    discoverNews = [];
    notifyListeners();
    getDiscoverNews();
  }

  String searchTitle = '';
  searchTitleNews(String title){
    searchTitle = title;
    searchNews = [];
    notifyListeners();
    getSearchNews();
  }

  getBreakingNews()async{
    news =await DioHelper.dioHelper.getBreakingNews();
    log(news.length.toString());
    notifyListeners();
  }

  getAllNews()async{
    allNews =await DioHelper.dioHelper.getAllNews();
    log(allNews.length.toString());
    notifyListeners();
  }

  getDiscoverNews()async{
    discoverNews = await DioHelper.dioHelper.getDiscoverNews(selectNews);
    log(discoverNews.length.toString());
    notifyListeners();
  }

  getSearchNews()async{
    searchNews = await DioHelper.dioHelper.getSearchNews(searchTitle);
    log(searchNews.length.toString());
    notifyListeners();
  }
}