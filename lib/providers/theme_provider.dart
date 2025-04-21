import 'package:evently/utils/shared_pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
 
  ThemeProvider() {
    _loadTheme();
  }
  Future<void> changeTheme(ThemeMode newTheme) async {
    if (currentTheme == newTheme) {
      return;
    }
    currentTheme = newTheme;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefKey.themeLastState, newTheme.toString());
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? themeString = prefs.getString(PrefKey.themeLastState);
    if (themeString != null) {
      currentTheme =
          themeString == 'ThemeMode.dark' ? ThemeMode.dark : ThemeMode.light;
    }
    notifyListeners();
  }
}
