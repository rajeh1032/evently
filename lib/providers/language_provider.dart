import 'package:evently/utils/shared_pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLanguage = 'en';
  LanguageProvider() {
    _loadLanguage();
  }

  Future<void> changeLangauge(String newLanguage) async {
    if (currentLanguage == newLanguage) {
      return;
    }
    currentLanguage = newLanguage;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefKey.languageLastState, newLanguage);
    notifyListeners();
  }

  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageString = prefs.getString(PrefKey.languageLastState);
    if (languageString != null) {
      currentLanguage = languageString;
    }
    notifyListeners();
  }
}
