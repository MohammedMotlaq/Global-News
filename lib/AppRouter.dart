import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  static pushWithReplacment(Widget widget) {
    Navigator.of(navKey.currentContext!)
        .pushReplacement(MaterialPageRoute(builder: (context) => widget));
  }

  static pushWidget(Widget widget) {
    Navigator.of(navKey.currentContext!)
        .push(MaterialPageRoute(builder: (context) => widget));
  }

  static popWidget() {
    Navigator.pop(navKey.currentContext!);
  }

  static showErrorSnackBar(String title, String message) {
    ScaffoldMessenger.of(navKey.currentContext!)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        content: AwesomeSnackbarContent(
            title: title, message: message, contentType: ContentType.failure),
      ));
  }

  static showSnackBar(String title, String message) =>
      ScaffoldMessenger.of(navKey.currentContext!)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          content: AwesomeSnackbarContent(
              title: title, message: message, contentType: ContentType.success),
      ));
}
