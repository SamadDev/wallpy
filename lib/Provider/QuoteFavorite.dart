import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavQuote with ChangeNotifier {
  List<String> quoteList = [];

  Future<void> fetchQuote() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      quoteList = preferences.getStringList('quote') ?? [];
      print(quoteList);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  addQuote({quote}) async {
    try {
      quoteList.add(quote);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setStringList('quote', quoteList);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  removeQuote({quote}) async {
    try {
      quoteList.removeAt(quoteList.indexOf(quote));
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setStringList('quote', quoteList);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
