import 'package:flutter/material.dart';
import 'package:new_wallpaper/Component/Sipnner.dart';
import 'package:provider/provider.dart';
import 'package:new_wallpaper/Provider/DarkMode.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:new_wallpaper/screens/TabPhotoScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    Future.delayed(Duration(seconds: 0),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Tab_Bar()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Language>(context,listen:false).getLanguageDataInLocal();
    Provider.of<DarkThemePreference>(context,listen:false).getTheme();
    return  Center(child: Spinner(),);
  }
}
