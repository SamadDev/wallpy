import 'package:flutter/material.dart';
import 'package:new_wallpaper/Component/LunchUrl.dart';
import 'package:new_wallpaper/screens/AboutScreen.dart';
import 'package:new_wallpaper/screens/TabFavorite.dart';
import 'package:new_wallpaper/screens/TabPhotoScreen.dart';
import 'package:new_wallpaper/screens/TabQuoteScreen.dart';
import 'package:new_wallpaper/screens/TabVideoScreen.dart';
import 'package:provider/provider.dart';
import 'package:new_wallpaper/theme/style.dart';

import '../Provider/DarkMode.dart';
import '../localization/language.dart';

class DrawerScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context);
    return Drawer(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color(0xff008080),
                margin: EdgeInsets.zero,
                height: 230,
                width: double.infinity,
                child: DrawerHeader(
                    child: Image.asset(
                  'assets/images/walpy.jpg',
                  fit: BoxFit.cover,
                )),
              ),
              setting(
                  icon: Icons.photo,
                  text: language.words['photo'],
                  context: context,
                  function: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) => Tab_Bar()));
                  }),
              Divider(
                color: Theme.of(context).buttonColor.withOpacity(0.1),
              ),
              setting(
                  icon: Icons.play_circle_fill,
                  text: language.words['video'],
                  context: context,
                  function: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => VideoTbaBAr()));
                  }),
              setting(
                  icon: Icons.format_quote,
                  text: language.words['quote'],
                  context: context,
                  function: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => TabBarQuote()));
                  }),

              Divider(
                color: Theme.of(context).buttonColor.withOpacity(0.1),
              ),

              setting(
                  icon: Icons.favorite,
                  text: language.words['favorite'],
                  context: context,
                  function: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => TabFavorite()));
                  }),
              Divider(
                color: Theme.of(context).buttonColor.withOpacity(0.1),
              ),
              setting(
                  context: context,
                  text: language.words['language'],
                  icon: Icons.language,
                  function: () {
                    languageChange(
                        text: language.words['language'], context: context);
                  },
                  trailer: language.languageCode == 'en'
                      ? Text(
                          'English',
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      : language.languageCode == 'ar'
                          ? Text(
                              'عربی',
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          : Text(
                              'کوردی',
                              style: Theme.of(context).textTheme.bodyText1,
                            )),
              Divider(
                color: Theme.of(context).buttonColor.withOpacity(0.1),
              ),
              setting(
                  context: context,
                  text: language.words['change mode'],
                  icon: Icons.nightlight_round,
                  trailer:
                      Consumer<DarkThemePreference>(builder: (ctx, mode, _) {
                    Provider.of<DarkThemePreference>(context).getTheme();
                    var val = mode.darkTheme;
                    return Switch(
                        activeColor: AppTheme.green,
                        value: val,
                        onChanged: (value) {
                          val = value;
                          Provider.of<DarkThemePreference>(context,
                                  listen: false)
                              .setDarkTheme(value);
                        });
                  })),
              Divider(
                color: Theme.of(context).buttonColor.withOpacity(0.1),
              ),
              setting(
                  icon: Icons.info_outline,
                  text: language.words['about'],
                  context: context,
                  function: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => AboutScreen()));
                  }),
              Divider(
                color: Theme.of(context).buttonColor.withOpacity(0.1),
              ),
              setting(
                  icon: Icons.bug_report_outlined,
                  text: language.words['send problem'],
                  context: context,
                  function: () {
                    launchURL(
                        url: 'whatsapp://send?phone=+9647810520687',
                        context: context,
                        title: 'ۆڵپی');
                  },
                  )
            ],
          ),
        ),
      ),
    );
  }
}


class _LanguageButton extends StatelessWidget {
  final String label;
  final String code;
  final String direction;

  const _LanguageButton(
      {required this.label, required this.code, required this.direction});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Provider.of<Language>(context, listen: false)
            .setLanguage(code, direction);
        Navigator.of(context).pop();
      },
      child: Text(label, style: Theme.of(context).textTheme.headline4),
    );
  }
}

Widget setting({context, icon, text, trailer, function}) {
  return ListTile(
    trailing: trailer,
    onTap: function,
    leading: Icon(
      icon,
      color: Theme.of(context).buttonColor,
    ),
    title: Text(
      text,
      style: Theme.of(context).textTheme.headline4,
    ),
  );
}

languageChange({context, text}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 10),
          Divider(),
          _LanguageButton(label: 'کوردی', code: 'kr', direction: 'rtl'),
          _LanguageButton(label: 'English', code: 'en', direction: 'ltr'),
          _LanguageButton(label: 'عربی', code: 'ar', direction: 'rtl')
        ],
      ),
    ),
  );
}
