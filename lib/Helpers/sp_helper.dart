import 'package:news_app/Providers/ui_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPHelper{
  static late SharedPreferences _sp;
  static UiProvider uiProvider= UiProvider();
  static bool dark = true;
  static initializeSp() async {
    _sp = await SharedPreferences.getInstance();
  }

  static getIsDark() {
    return _sp.getBool("isDark") ?? true;
  }

  static changeIsDark() {
    bool isDark = getIsDark();
    _sp.setBool("isDark", !isDark);
    uiProvider.changeThemes();
  }

}