import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalVideoFav with ChangeNotifier {
  List<String> videoFavorite = [];
  List<String> videoPicture = [];

  Future<void> fetchVideoFavorite() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      videoFavorite = preferences.getStringList('url') ?? [];
      videoPicture = preferences.getStringList('picture') ?? [];
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  addVideoFavorite({video, picture}) async {
    try {
      videoFavorite.add(video);
      videoPicture.add(picture);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setStringList('url', videoFavorite);
      preferences.setStringList('picture', videoPicture);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  removeVideoFavorite({url, picture}) async {
    try {
      videoFavorite.removeAt(videoFavorite.indexOf(url));
      videoPicture.removeAt(videoPicture.indexOf(picture));
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setStringList('url', videoFavorite);
      preferences.setStringList('picture', videoPicture);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
