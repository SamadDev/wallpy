import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:new_wallpaper/module/VideoModule.dart';

class Video with ChangeNotifier {
  VideosModule? videoModule;

  Future<void> getVideo(category, page, {bool remove = true}) async {
    try {
      final response = await http.get(
          Uri.parse("https://api.pexels.com/videos/search?query=$category&per_page=35&page=$page"),
          headers: {'Authorization': 'mKftJkYPEiaQ28j4xAdRuNJO64fKVVNzHH5sb1kTwDUoy4szmoSWKU6b'});
      var jsonData = json.decode(response.body);

      if (videoModule == null) {
        videoModule = VideosModule.fromJson(jsonData);
        notifyListeners();
      } else {
        if (remove == false) {
          videoModule!.videos.clear();
        }
        VideosModule model2 = VideosModule.fromJson(jsonData);
        videoModule!.videos.addAll(model2.videos.toList());
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

  VideosModule? searchModule;

  Future<void> search(page, {bool remove = true, String category = 'all'}) async {
    try {
      if (searchModule == null || remove == false) {
        changeIsNull();
        changeState();
      }
      final response = await http.get(
          Uri.parse("https://api.pexels.com/videos/search?query=$category&per_page=35&page=$page"),
          headers: {'Authorization': 'mKftJkYPEiaQ28j4xAdRuNJO64fKVVNzHH5sb1kTwDUoy4szmoSWKU6b'});
      var jsonData = json.decode(response.body);
      print(jsonData);
      if (searchModule == null) {
        searchModule = VideosModule.fromJson(jsonData);
        changeState();
        notifyListeners();
      } else {
        if (remove == false) {
          searchModule!.videos.clear();
          changeState();
        }
        VideosModule model2 = VideosModule.fromJson(jsonData);
        searchModule!.videos.addAll(model2.videos.toList());
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

  bool isNull = false;
  void changeIsNull() {
    isNull = true;
    notifyListeners();
  }

  bool isSearch = false;
  void changeState() {
    isSearch = !isSearch;
    notifyListeners();
  }
}
