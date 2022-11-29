import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Language with ChangeNotifier {
  // language dir
  String languageDirection = 'rtl';

  // language code
  String languageCode = 'kr';

  void setLanguage(code, direction) async {
    languageCode = code;
    languageDirection = direction;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('languageCode', languageCode);
    sharedPreferences.setString('languageDirection', languageDirection);
    notifyListeners();
  }

  Future<void> getLanguageDataInLocal() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    languageCode = sharedPreferences.getString('languageCode') ?? 'kr';
    languageDirection =
        sharedPreferences.getString('languageDirection') ?? 'ltr';
    notifyListeners();
  }

  Map<String, dynamic> get words => _words[languageCode];

// language words
  Map _words = {
    'kr': {
      'language': 'کوردی',
      "change mode": 'گۆرینی دۆخ',
      "dark mode": 'دۆخی تاریک',
      "share": "بەشکردن",
      "download": 'دابەزاندن',
      "favorite": "دڵخواز",
      "all": "گشتی",
      "nature": "سروشت",
      "technology": "تەکنەلۆجیا",
      "animal": 'ئاژەڵ',
      "fashion": 'فاشیۆن',
      "baby": "منداڵ",
      "travel": "گەشت",
      "anime": "ئەنیمەی",
      "moon": "مانگ",
      "kurdistan": "کردستان",
      "flag": "ئاڵا",
      "funny": "خەندەئامێز",
      "game": "گەیم",
      "architecture": "شارستانیەت",
      "laptop": "لاپتۆپ",
      'programing': 'پرۆگرامینینگ',
      "health & wealth": "سەروتو و تەندروستی",
      "culture": "کەلتور",
      'message': "چاوەڕوانی......",
      "video": ' ڤیدیۆکان',
      'favorite video': 'ڤیدۆ دڵخوازەکان',
      'favorite photo': 'وێنە دڵخوازەکان',
      "photo": 'وێنەکان',
      'about': 'دەربارە',
      "quote":"وتە",
      'english quote':"وتەی ئینگلێزی",
      'kurdish quote':'وتەی کوردی',
      'arabic quote':'وتەی عەرەبی',
      "favorite quote":"وتە دڵخوازەکان",
      'copy':'کۆپی',
      "error":"ببورە هەڵەیەک رویدا",
      'connection': "تکایە دڵنیابەوە لە هەبوونی ئینتەرنێت",
      'search to photo': "گەران بۆ وێنە...",
      'search to video': "گەران بۆ ڤیدۆ...",
      'send problem': "ناردنی کێشە",
      'wal': 'بەرنامەی ۆڵپی',
      'about wal':
          'ۆڵپی بەرنامەیەکە دەتوانی لەرێگەی سەیری وێنەو ڤیدۆبکەیت و دایبەزێنیت وە هەندێک تایبەتمەندیتریش',
      "show": "پیشانم مەدەوە"
    },
    'en': {
      'language': 'language',
      'change mode': 'Change mode',
      "dark mode": 'Dark mode',
      "share": "share",
      "download": 'download',
      "favorite": "favorite",
      "all": "all",
      "nature": "nature",
      "technology": "technology",
      'programing': 'programing',
      "animal": "animal",
      "funny": "funny",
      "game": "game",
      "fashion": 'fashion',
      "baby": "baby",
      "travel": "travel",
      "anime": "anime",
      "moon": "moon",
      "kurdistan": "kurdistan",
      "flag": "flag",
      "architecture": "architecture",
      "laptop": "laptop",
      "health & wealth": "health & wealth",
      "culture": "culture",
      'message': "loading .....",
      "video": 'videos',
      "photo": "photos",
      'favorite video': "favorite videos",
      "favorite photo": "favorite photos",
      'about': 'about',
      "error":"sorry something went wrong",
      'connection': "please be sure about you internet",
      'search to photo': "search to photo...",
      'search to video': 'search to video...',
      "quote":"quote",
      'english quote':"english quote",
      'kurdish quote':'kurdish quote',
      'arabic quote':'arabic quote',
      "favorite quote":"favorite quote",
      'copy':'copy',

      'send problem': 'send problem',
      'wal': 'walpy application',
      'about wal':
          'walpy is an application for for watching and downloading wallpaper and video with some other futures'
    ,'show':"Don't show me."
    },
    'ar': {
      'language': 'عربی',
      "change mode": 'تغیر مود',
      "dark mode": ' حالة مظلمة',
      "share": "اشتراک",
      "download": 'ینزیل',
      "favorite": "المفضله",
      "all": "عام",
      "nature": "طبیعە",
      "technology": "تکنلوجیا",
      "animal": 'حیوانات',
      "fashion": 'فاشیون',
      "baby": "اطفال",
      "travel": "صیاحە",
      "anime": "ئەنیمەی",
      "moon": "قمر",
      "funny": "مضحکە",
      "game": "العاب",
      "kurdistan": "کردستان",
      "flag": "علم",
      "architecture": "تمدن",
      "laptop": "لابتوب",
      'programing': 'برمجة',
      "health & wealth": "الصحة والصحة",
      "culture": "عادة",
      'message': "انتیظار......",
      "video": ' ڤیدیوهات',
      'favorite video': 'مفضلات الفيديو',
      'favorite photo': 'الصور المفضلة',
      "photo": 'الصور',
      "quote":"اقتیباس",
      'english quote':"اقتباس انجلیزی",
      'kurdish quote':'اقتیباس کردی',
      'arabic quote':'اقتیباس عربی',
      "favorite quote":"مفضلات اقتیباس",
      'copy':'کوبی',
      'about': 'عن',
      "error":"آسف حدث خطأ ما",
      'connection': "الرجاء التأكد من أن لديك الإنترنت",
      'search to photo': "البحث عن الصورة...",
      'search to video': 'البحث عن الفيديو...',
      'send problem': "إرسال المشكلة",
      'wal': 'تطبيق ۆڵپی',
      'about wal':
          'walpy هو تطبيق لمشاهدة وتحميل ورق الجدران والفيديو مع بعض العقود الآجلة الأخرى'
   ,"show":"لا تريني" }
  };
}
