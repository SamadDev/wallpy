import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:new_wallpaper/Component/DetailIcon.dart';
import 'package:new_wallpaper/Component/File_Downloder.dart';
import 'package:new_wallpaper/Component/ToolTipWidget.dart';
import 'package:new_wallpaper/Provider/PhotoFavorite.dart';
import 'package:new_wallpaper/Provider/ShowToolTip.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:new_wallpaper/module/PhotoModule.dart';
import 'package:new_wallpaper/theme/style.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final index;
  final PixelModel? list;

  DetailScreen({this.index, this.list});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    // Provider.of<IsShow>(context, listen: false).fetchIsShow();
    controller = PageController(initialPage: widget.index);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> callFunction() async {
    Provider.of<IsShow>(context, listen: false).fetchIsShow();
    Provider.of<SLocalStorage>(context, listen: false).fetchLoveList();
  }

  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: callFunction(),
        builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
            ? CircularProgressIndicator()
            : Consumer<IsShow>(
                builder: (ctx, show, _) => PageView.builder(
                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  controller: controller,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.list!.photos!.length,
                  itemBuilder: (ctx, i) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget
                                .list!.photos![i].src!.portrait
                                .toString()),
                            fit: BoxFit.fill)),
                    child: show.showPicture
                        ? ToolTipWidget(
                      onPress:   () {
                      show.setIsShow();
                },
                    )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(Icons.arrow_back_ios_outlined),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  DetailIcon(
                                    onTap: () {
                                      Share.share(
                                          widget.list!.photos![i].src!.portrait
                                              .toString(),
                                          subject: 'ؤلپی');
                                    },
                                    text: language.words['share'],
                                    icon: Icon(
                                      Icons.share_outlined,
                                      size: 30,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                  FileDownloadWidget(
                                      url: widget.list!.photos![i].src!.portrait
                                          .toString()),
                                  FutureBuilder(
                                    future: Provider.of<SLocalStorage>(context,
                                            listen: false)
                                        .fetchLoveList(),
                                    builder: (ctx, snap) => snap
                                                .connectionState ==
                                            ConnectionState.waiting
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : DetailIcon(
                                            text: language.words['favorite'],
                                            bgColor: AppTheme.green,
                                            icon: Consumer<SLocalStorage>(
                                              builder: (ctx, love, _) =>
                                                  GestureDetector(
                                                onTap: () {
                                                  if (love.courseList.contains(
                                                      widget.list!.photos![i]
                                                          .src!.portrait
                                                          .toString())) {
                                                    love.removeCourse(
                                                        url: widget
                                                            .list!
                                                            .photos![i]
                                                            .src!
                                                            .portrait
                                                            .toString());
                                                  } else {
                                                    love.addToLoveList(
                                                        photo: widget
                                                            .list!
                                                            .photos![i]
                                                            .src!
                                                            .portrait
                                                            .toString());
                                                  }
                                                },
                                                child: love.courseList.isEmpty
                                                    ? Icon(
                                                        Icons.favorite_border,
                                                        color: AppTheme.black2,
                                                        size: 30,
                                                      )
                                                    : love.courseList.contains(
                                                            widget
                                                                .list!
                                                                .photos![i]
                                                                .src!
                                                                .portrait
                                                                .toString())
                                                        ? Icon(
                                                            Icons.favorite,
                                                            color:
                                                                AppTheme.black2,
                                                            size: 30,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color:
                                                                AppTheme.black2,
                                                            size: 30,
                                                          ),
                                              ),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                ),
              ),
      ),
    );
  }
}
