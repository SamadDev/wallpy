import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IsShow with ChangeNotifier {
  bool showPicture = true;
  bool showVideo = true;

  Future<void> fetchIsShow() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    showPicture = preferences.getBool('show') ?? true;
    showVideo = preferences.getBool('showVideo') ?? true;
    print(showVideo);
    notifyListeners();
  }

  setIsShow() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('show', false);
    fetchIsShow();
    notifyListeners();
  }

  setIsShowVideo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('showVideo', false);
    fetchIsShow();
    notifyListeners();
  }

  remove() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('show');
    preferences.remove('showVideo');
    print(showPicture);
    notifyListeners();
  }
}
