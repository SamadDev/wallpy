import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color green = Colors.teal;
  static const Color orange = Color(0xfffea41b);
  static const Color navy = Color(0xff736ff4);
  static const Color black1 = Color(0xff3e3e3e);
  static const Color black2 = Color(0xffe4e8eb);
  static const Color black3 = Color(0xffd2d2d2);
  static Color transparent=Colors.transparent;
  static const Color white = Colors.white;
  static Color black4 = Color(0xff3e3e3e).withOpacity(0.2);
  static Color lightBlueAccent = Colors.lightBlueAccent;

  //light theme of the application
  static final ThemeData lightTheme = ThemeData(
    buttonColor: AppTheme.black1,
    cardColor: AppTheme.black2,
    scaffoldBackgroundColor: AppTheme.black2,
    backgroundColor: AppTheme.black2,
    brightness: Brightness.light,
    primaryColor: AppTheme.black2,
    textTheme: lightTextTheme,
  );

  //dark theme of the whole application
  static final ThemeData darkTheme = ThemeData(
    buttonColor: AppTheme.black2,
    cardColor: Color(0xff1a1b29),
    scaffoldBackgroundColor: Color(0xff1a1b29),
    shadowColor: Colors.black,
    brightness: Brightness.light,
    primaryColor: Color(0xff1a1b29),
    textTheme: darkTextTheme,
  );

  //Dark Text theme of the application
  static final TextTheme darkTextTheme = TextTheme(
    headline2: _highlight.copyWith(color: AppTheme.green),
    headline4: _headline4.copyWith(color: Colors.white),
    headline5: _headline5.copyWith(color: Colors.black87),
    button: _button.copyWith(color: AppTheme.green),
    caption: _subtitle1.copyWith(color: AppTheme.white),
    subtitle1: _subtitle1.copyWith(color: Colors.white),
    bodyText1: _bodyText1.copyWith(color: AppTheme.white),
    headline3: _quote.copyWith(color: AppTheme.white),
    headline6: _auth.copyWith(color: AppTheme.white)
  );

  //Light dark theme of the application
  static final TextTheme lightTextTheme = TextTheme(
    headline1: _headline1,
    headline2: _highlight,
    headline4: _headline4,
    headline5: _headline5,
    headline3: _quote,
    headline6: _auth,
    button: _button,
    subtitle1: _subtitle1,
    bodyText1: _bodyText1,
    caption: _caption,

  );

  static final TextStyle _headline1 = TextStyle(
    color: AppTheme.green,
    fontWeight: FontWeight.w700,
    fontFamily: 'nrt',
    fontSize: 35,
  );

  static final TextStyle _headline4 = TextStyle(
    color: AppTheme.black1,
    fontWeight: FontWeight.w400,
    fontFamily: 'nrt',
    fontSize: 18,
  );
  static final TextStyle _headline5 = TextStyle(
    fontFamily: 'nrt',
    color: AppTheme.green,
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );

  static final TextStyle _button = TextStyle(
    fontFamily: 'nrt',
    color: AppTheme.white,
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  static final TextStyle _subtitle1 = TextStyle(
    fontFamily: 'nrt',
    color: AppTheme.green,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  static final TextStyle _bodyText1 = TextStyle(
    fontFamily: 'nrt',
    color: AppTheme.black1,
    fontWeight: FontWeight.w400,
    fontSize: 15,
  );
  static final TextStyle _caption = TextStyle(
    fontFamily: 'nrt',
    color: AppTheme.black1,
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );

  static final TextStyle _highlight =
  GoogleFonts.anton(fontSize: 40, color: AppTheme.green);

  static final TextStyle _quote =
      GoogleFonts.indieFlower(fontSize: 30, color: AppTheme.black1);
  static final TextStyle _auth =
      GoogleFonts.indieFlower(fontSize: 20, color: AppTheme.black1,);
}
