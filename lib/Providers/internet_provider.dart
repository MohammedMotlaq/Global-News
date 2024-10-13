import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app/AppRouter.dart';
import 'package:news_app/Screens/Home/home_page.dart';
//import 'package:rounded_loading_button/rounded_loading_button.dart';

class InternetProvider extends ChangeNotifier{

  //RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  checkInternetConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      //btnController.success();
      Future.delayed(const Duration(seconds: 1), () async {
        AppRouter.pushWithReplacment(const HomePage());
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () async {
        //btnController.error();
      });
    }

    Future.delayed(const Duration(seconds: 3), () async {
      //btnController.reset();
    });
  }
}