import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeProvider with ChangeNotifier {
  bool isDark = false;

  void initializeDarkMode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    isDark = preferences.getBool("is_dark") ?? false;

    notifyListeners();
  }

  void switchMode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("is_dark", !isDark);
    
    initializeDarkMode();
  }
}
