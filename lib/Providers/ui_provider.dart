import 'package:flutter/material.dart';

import '../screens/news_widgets/breaking_news.dart';
import '../screens/news_widgets/discover_page.dart';
import '../screens/news_widgets/popular_page.dart';
import '../screens/news_widgets/search_page.dart';



class UiProvider extends ChangeNotifier{
  UiProvider(){
    chosenIndexWidget();
    notifyListeners();
  }
  int chosenIndex =0;
  chosenIndexWidget(){
    if(chosenIndex == 0){
      return BreakingNews();
    }else if(chosenIndex == 1){
      return PopularPage();
    }
    else if(chosenIndex == 2){
      return DiscoverPage();
    }
    else if(chosenIndex == 3){
      return SearchPage();
    }
    notifyListeners();
  }

  Color pageColor = Colors.black;
  chosenIndexColor(){
    if(chosenIndex == 0){
      return pageColor =Colors.red;
    }else if(chosenIndex == 1){
      return pageColor =Colors.blue;
    }
    else if(chosenIndex == 2){
      return pageColor =Colors.green;
    }
    else if(chosenIndex == 3){
      return pageColor =Colors.cyan;
    }
    return pageColor;
  }

  String title = '';
  changeTitleNews(){
    if(chosenIndex == 0){
      return title = 'Breaking';
    }else if(chosenIndex == 1){
      return title = 'Popular';
    }
    else if(chosenIndex == 2){
      return title = 'Discover';
    }
    else if(chosenIndex == 3){
      return title = 'Search';
    }
    return title;
  }


  getIndex(int index){
    chosenIndex = index;
    notifyListeners();
  }
}