import 'package:flutter/material.dart';
import 'package:new_wallpaper/Provider/PhotoFavorite.dart';
import 'package:new_wallpaper/Provider/LocalQuote.dart';
import 'package:new_wallpaper/Provider/QuoteFavorite.dart';
import 'package:new_wallpaper/Provider/ShowToolTip.dart';
import 'package:new_wallpaper/Provider/VideoFavorite.dart';
import 'package:new_wallpaper/Component/ErrorScreen.dart';
import 'package:new_wallpaper/screens/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'package:new_wallpaper/Provider/Photo.dart';
import 'package:new_wallpaper/Provider/Video.dart';
import 'package:new_wallpaper/theme/style.dart';
import 'Provider/Connectivity.dart';
import 'Provider/DarkMode.dart';
import 'localization/language.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  ErrorWidget.builder = (ctx) => Scaffold(
    body: ErrorScreen(),
  );
  runApp(ProviderWidget());
}

class ProviderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: MyApp(),
        ),
        ChangeNotifierProvider(create: (_) => Language()),
        ChangeNotifierProvider(create: (_) => Video()),
        ChangeNotifierProvider(create: (_) => SLocalStorage()),
        ChangeNotifierProvider(create: (_) => DarkThemePreference()),
        ChangeNotifierProvider(create: (_)=>IsShow(),),
        ChangeNotifierProvider(create: (_)=>Quote(),),
        ChangeNotifierProvider(create: (_)=>FavQuote(),),
        ChangeNotifierProvider(create: (_) => Pixel()),
        ChangeNotifierProvider(
          create: (_) => LocalVideoFav(),
        )
      ],
      child: MyApp(),
    );
  }
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context);
    return Consumer<DarkThemePreference>(
      builder: (context, theme, state) {
        return  MaterialApp(
          builder: (ctx, child) {
            return Directionality(
              textDirection: language.languageCode == 'en'
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          theme: theme.darkTheme == false
              ? AppTheme.darkTheme
              : AppTheme.lightTheme,
          home: SplashScreen(),
        );
      },
    );
  }
}
