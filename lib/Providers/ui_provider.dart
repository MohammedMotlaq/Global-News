import 'package:flutter/material.dart';
import 'package:news_app/AppRouter.dart';
import 'package:news_app/Models/news_model.dart';
import 'package:news_app/Providers/db_provider.dart';
import 'package:provider/provider.dart';
import '../screens/news_widgets/breaking_news.dart';
import '../screens/news_widgets/discover_page.dart';
import '../screens/news_widgets/popular_page.dart';
import '../screens/news_widgets/search_page.dart';

class UiProvider extends ChangeNotifier {
  UiProvider() {
    chosenIndexWidget();
    changeIsDark();
    changeIsDark();
    notifyListeners();
  }

  int chosenIndex = 0;
  bool isDark = true;
  bool themeColor = false;

  chosenIndexWidget() {
    if (chosenIndex == 0) {
      return BreakingNews();
    } else if (chosenIndex == 1) {
      return PopularPage();
    } else if (chosenIndex == 2) {
      return DiscoverPage();
    } else if (chosenIndex == 3) {
      return SearchPage();
    }
    notifyListeners();
  }

  String title = '';
  changeTitleNews() {
    if (chosenIndex == 0) {
      return title = 'Breaking';
    } else if (chosenIndex == 1) {
      return title = 'Popular';
    } else if (chosenIndex == 2) {
      return title = 'Discover';
    } else if (chosenIndex == 3) {
      return title = 'Search';
    }
    return title;
  }

  getIndex(int index) {
    chosenIndex = index;
    notifyListeners();
  }

  checkFav(NewsModel newsModel) {
    if (newsModel.id == null) return false;
    bool isFound = false;
    Provider.of<DbProvider>(AppRouter.navKey.currentContext!)
        .favoritesNews
        .forEach((element) {
      if (element.id == newsModel.id) {
        isFound = true;
        return;
      }
    });
    return isFound;
  }

  changeIsDark(){
    if(isDark == true){
      themeColor = true;
      isDark = false;
      changeThemes();
    }else {
      themeColor = false;
      isDark = true;
      changeThemes();
    }
    notifyListeners();
  }

  Color drawerBackgroundColor = Colors.white;
  Color appBarColor = const Color.fromRGBO(173, 2, 0, 1.0);
  Color scaffoldColor = Colors.white;
  Color bottomNavColor = Colors.white;
  String shareIcon = 'assets/icons/shareblack.png';
  Color premaryColor = const Color.fromRGBO(3, 83, 238, 0.8745098039215686);
  Color textColor = Colors.white;
  Color lineColor = Colors.black;
  Color selectedItem = const Color.fromRGBO(173, 2, 0, 1.0);
  String loveIconColor = 'assets/icons/loveblack.png';
  Color searchBox = Colors.grey.shade300;
  Color searchIcon = const Color.fromRGBO(173, 2, 0, 1.0);
  Color textSearch = Colors.black;
  Color textButtonDrawer = Colors.grey.shade200;
  String darkIcon = 'assets/icons/sunblack.png';
  String agentIcon = 'assets/icons/agentblack.png';
  String mode = '   Light Mode';

  changeThemes(){
    if(themeColor == true){//dark
      drawerBackgroundColor = const Color.fromRGBO(21, 21, 21, 1.0);
      shareIcon = 'assets/icons/sharewhite.png';
      premaryColor = Colors.white;
      textColor = Colors.white;
      scaffoldColor = const Color.fromRGBO(21, 21, 21, 1.0);
      appBarColor = const Color.fromRGBO(52, 52, 52, 1.0);
      bottomNavColor = const Color.fromRGBO(52, 52, 52, 1.0);
      lineColor = const Color.fromRGBO(52, 52, 52, 1.0);
      selectedItem = Colors.white;
      loveIconColor = 'assets/icons/lovewhite.png';
      searchBox = Colors.grey.shade800;
      searchIcon = Colors.white;
      textSearch = Colors.white;
      textButtonDrawer = Colors.grey.shade800;
      darkIcon = 'assets/icons/moonwhite.png';
      agentIcon = 'assets/icons/agentwhite.png';
      mode = '   Dark Mode';

    }else{//light
      drawerBackgroundColor = Colors.white;
      shareIcon = 'assets/icons/shareblack.png';
      premaryColor = Colors.white;
      textColor = Colors.black;
      scaffoldColor = Colors.white;
      appBarColor = const Color.fromRGBO(173, 2, 0, 1.0);
      bottomNavColor = Colors.white;
      lineColor = const Color.fromRGBO(176, 174, 174, 1.0);
      selectedItem = const Color.fromRGBO(173, 2, 0, 1.0);
      loveIconColor = 'assets/icons/loveblack.png';
      searchBox = Colors.grey.shade300;
      searchIcon = const Color.fromRGBO(173, 2, 0, 1.0);
      textSearch = Colors.black;
      textButtonDrawer = Colors.grey.shade200;
      darkIcon = 'assets/icons/sunblack.png';
      agentIcon = 'assets/icons/agentblack.png';
      mode = '   Light Mode';
    }
    notifyListeners();
  }

}
