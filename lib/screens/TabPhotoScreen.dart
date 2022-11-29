import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:new_wallpaper/screens/DrawerScreen.dart';
import 'package:new_wallpaper/screens/HomePhotoScreen.dart';
import 'package:new_wallpaper/screens/SearchPhotoScreen.dart';
import 'package:new_wallpaper/theme/style.dart';
import 'package:provider/provider.dart';

class Tab_Bar extends StatelessWidget {
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return DefaultTabController(
      length: 17,
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
                            language.words['photo'],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          elevation: 0,
                          toolbarHeight: 60,
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => SearchScreen()));
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
                              Tab(child: Text(language.words['programing']),),
                              Tab(child: Text(language.words['animal'])),
                              Tab(child: Text(language.words['fashion'])),
                              Tab(child: Text(language.words['baby'])),
                              Tab(child: Text(language.words['travel'])),
                              Tab(child: Text(language.words['moon'])),
                              Tab(child: Text(language.words['flag'])),
                              Tab(child: Text(language.words['architecture'])),
                              Tab(child: Text(language.words['laptop'])),
                              Tab(child: Text(language.words['programing']),),
                              Tab(child: Text(language.words['health & wealth'])),
                              Tab(child: Text(language.words['culture'])),
                            ],
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: <Widget>[
                        HomeScreen(remove: false, category: 'all'),
                        HomeScreen(remove: false,category: 'funny',),
                        HomeScreen(remove: false,category: 'game'),
                        HomeScreen(remove: false, category: 'nature'),
                        HomeScreen(remove: false, category: 'technology'),
                        HomeScreen(remove: false, category: 'programing'),
                        HomeScreen(remove: false, category: 'animal'),
                        HomeScreen(remove: false, category: "fashion"),
                        HomeScreen(remove: false, category: "baby",),
                        HomeScreen(remove: false, category: 'travel',),
                        HomeScreen(remove: false, category: "moon",),
                        HomeScreen(remove: false, category: 'flag',),
                        HomeScreen(remove: false, category: 'architecture',),
                        HomeScreen(remove: false, category: 'laptop'),
                        HomeScreen(remove: false, category: "programing"),
                        HomeScreen(remove: false, category: 'health & wealth'),
                        HomeScreen(remove: false, category: 'culture'),
                      ],
                    ),
                  ),
          ),
    );
  }
}
