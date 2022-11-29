

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference extends ChangeNotifier {
  bool _darkTheme = true;

  bool get darkTheme => _darkTheme;

  setDarkTheme(value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs
          .setBool('THEMESTATUS', value)
          .then((val) => _darkTheme = prefs.getBool('THEMESTATUS')!)
          .then((value) => notifyListeners());
    } catch (error) {
      print(error);
    }
  }

  Future<void> getTheme() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _darkTheme = prefs.getBool('THEMESTATUS')??false;
    } catch (error) {
      print(error);
    }
  }
}
