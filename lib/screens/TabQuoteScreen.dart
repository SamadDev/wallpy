import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:new_wallpaper/screens/DrawerScreen.dart';
import 'package:new_wallpaper/screens/QuoteArabicScreen.dart';
import 'package:new_wallpaper/screens/QuoteEnglishScreen.dart';
import 'package:new_wallpaper/screens/QuoteKurdishScreen.dart';
import 'package:new_wallpaper/theme/style.dart';
import 'package:provider/provider.dart';

class TabBarQuote extends StatelessWidget {
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: DrawerScreen(),
        body:  NestedScrollView(
          floatHeaderSlivers: true,
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          headerSliverBuilder: (context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                iconTheme: IconThemeData(color: Theme.of(context).buttonColor,),
                backgroundColor: Theme.of(context).cardColor,
                title: Text(
                  language.words['quote'],
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                elevation: 0,
                toolbarHeight: 60,
                forceElevated: true,
                floating: true,
                bottom: TabBar(
                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: ShapeDecoration(
                      color: AppTheme.green,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Theme.of(context).cardColor,
                          ))),
                  onTap: (int) {},
                  isScrollable: true,
                  tabs: [
                    Tab(child: Text(language.words['english quote'])),
                    Tab(child: Text(language.words['arabic quote'])),
                    Tab(child: Text(language.words['kurdish quote'])),

                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
             QuoteEnglishScreen(),
              QuoteArabicScreen(),
              QuoteKurdishScreen()
            ],
          ),
        ),
      ),
    );
  }
}
