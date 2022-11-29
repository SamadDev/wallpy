import 'dart:convert';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:new_wallpaper/module/PhotoModule.dart';


class Pixel with ChangeNotifier {
  PixelModel? module;

  Future<void> getPhotos(category, page, {bool remove = true}) async {
    try {
      final response = await http.get(
          Uri.parse(
              "https://api.pexels.com/v1/search?query=$category&per_page=45&page=$page"),
          headers: {
            'Authorization':
                'Bearer 563492ad6f917000010000018fe27b2e7b9749c7ab67dc5da14cf231'
          });

      var jsonData = json.decode(response.body);

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

  Future<void> search(page,
      {bool remove = true, String category = 'all'}) async {
    try {
      if (searchModule == null||remove==false) {
        changeIsNull();
        changeState();
      }
      final response = await http.get(
          Uri.parse(
              "https://api.pexels.com/v1/search?query=$category&per_page=30&page=$page"),
          headers: {
            'Authorization':
                'Bearer 563492ad6f917000010000018fe27b2e7b9749c7ab67dc5da14cf231'
          });
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


  bool isNull=false;
  void changeIsNull(){
    isNull=true;
    notifyListeners();
  }

  bool isSearch = false;

  void changeState() {
    isSearch = !isSearch;
    notifyListeners();
  }

}
