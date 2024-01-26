import 'dart:convert';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:new_wallpaper/module/PhotoModule.dart';

class Pixel with ChangeNotifier {
  PixelModel? module;

  Future<void> getPhotos(category, page, {bool remove = true}) async {
    try {
      final response = await http.get(
          Uri.parse("https://api.pexels.com/v1/search?query=$category&per_page=45&page=$page"),
          headers: {'Authorization': 'mKftJkYPEiaQ28j4xAdRuNJO64fKVVNzHH5sb1kTwDUoy4szmoSWKU6b'});

      var jsonData = json.decode(response.body);
      print(jsonData);

      if (module == null) {
        module = PixelModel.fromJson(jsonData);
        notifyListeners();
      } else {
        if (remove == false) {
          module!.photos!.clear();
        }
        PixelModel model2 = PixelModel.fromJson(jsonData);
        module!.photos!.addAll(model2.photos!.toList());
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

  PixelModel? searchModule;

  Future<void> search(page, {bool remove = true, String category = 'all'}) async {
    try {
      if (searchModule == null || remove == false) {
        changeIsNull();
        changeState();
      }
      print("_____________first_________");
      final response = await http.get(
          Uri.parse("https://api.pexels.com/v1/search?query=$category&per_page=45&page=$page"),
          headers: {'Authorization': 'mKftJkYPEiaQ28j4xAdRuNJO64fKVVNzHH5sb1kTwDUoy4szmoSWKU6b'});
      var jsonData = json.decode(response.body);
      if (searchModule == null) {
        searchModule = PixelModel.fromJson(jsonData);
        changeState();
        notifyListeners();
      } else {
        if (remove == false) {
          searchModule!.photos!.clear();
          changeState();
        }

        PixelModel model2 = PixelModel.fromJson(jsonData);
        searchModule!.photos!.addAll(model2.photos!.toList());
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
