import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:new_wallpaper/screens/DrawerScreen.dart';
import 'package:new_wallpaper/screens/FavoritePhotoScreen.dart';
import 'package:new_wallpaper/screens/FavoriteQuoteScreenn.dart';
import 'package:new_wallpaper/screens/FavoriteVideoScreen.dart';
import 'package:new_wallpaper/theme/style.dart';
import 'package:provider/provider.dart';

class TabFavorite extends StatelessWidget {
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
                  language.words['favorite'],
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
                  isScrollable: true,
                  tabs: [
                    Tab(child: Text(language.words['favorite photo'])),
                    Tab(child: Text(language.words['favorite video'])),
                    Tab(child: Text(language.words['favorite quote'])),

                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              FavoriteScreen(),
              FavoriteVideoScreen(),
              FavoriteQuoteScreen()
            ],
          ),
        ),
      ),
    );
  }
}
