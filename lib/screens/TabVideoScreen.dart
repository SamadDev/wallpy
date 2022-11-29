import 'package:flutter/material.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:new_wallpaper/screens/DrawerScreen.dart';
import 'package:new_wallpaper/screens/HomeVideoScreen.dart';
import 'package:new_wallpaper/screens/SearchVideoScreen.dart';
import 'package:new_wallpaper/theme/style.dart';
import 'package:provider/provider.dart';

class VideoTbaBAr extends StatelessWidget {
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return DefaultTabController(
      length:17,
      child: Scaffold(
          drawer: DrawerScreen(),
          body: NestedScrollView(
            floatHeaderSlivers: true,
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  title: Text(language.words['video'],style: Theme.of(context).textTheme.bodyText1,),
                  elevation: 0,
                  toolbarHeight: 60,
                  actions: [
                    TextButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>SearchVideo()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/s.png',
                          color: Theme.of(context).buttonColor,
                          width: 25,
                        ),
                      ),
                    ),
                  ],
                  backgroundColor: Theme.of(context).cardColor,
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
                      Tab(child: Text(language.words['all'])),
                      Tab(child: Text(language.words['funny'])),
                      Tab(child: Text(language.words['game'])),
                      Tab(child: Text(language.words['nature'])),
                      Tab(child: Text(language.words['technology'])),
                      Tab(
                        child: Text(language.words['programing']),
                      ),
                      Tab(child: Text(language.words['animal'])),
                      Tab(child: Text(language.words['fashion'])),
                      Tab(child: Text(language.words['baby'])),
                      Tab(child: Text(language.words['travel'])),
                      Tab(child: Text(language.words['moon'])),
                      Tab(child: Text(language.words['flag'])),
                      Tab(child: Text(language.words['architecture'])),
                      Tab(child: Text(language.words['laptop'])),
                      Tab(
                        child: Text(language.words['programing']),
                      ),
                      Tab(child: Text(language.words['health & wealth'])),
                      Tab(child: Text(language.words['culture'])),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                HomeVideoScreen(remove: false, category: 'all'),
                HomeVideoScreen(remove: false, category: 'funny'),
                HomeVideoScreen(remove: false, category: 'game'),
                HomeVideoScreen(remove: false, category: 'nature'),
                HomeVideoScreen(remove: false, category: 'technology'),
                HomeVideoScreen(remove: false, category: 'programing',),
                HomeVideoScreen(remove: false, category: 'animal',),
                HomeVideoScreen(remove: false, category: "fashion",),
                HomeVideoScreen(remove: false, category: "baby",),
                HomeVideoScreen(remove: false, category: 'travel',),
                HomeVideoScreen(remove: false, category: "moon",),
                HomeVideoScreen(remove: false, category: 'flag',),
                HomeVideoScreen(remove: false, category: 'architecture',),
                HomeVideoScreen(remove: false, category: 'laptop'),
                HomeVideoScreen(remove: false, category: "programing"),
                HomeVideoScreen(remove: false, category: 'health & wealth'),
                HomeVideoScreen(remove: false, category: 'culture'),
              ],
            ),
          )),
    );
  }
}
