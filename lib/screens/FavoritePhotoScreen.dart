import 'package:flutter/material.dart';
import 'package:new_wallpaper/Component/Sipnner.dart';
import 'package:new_wallpaper/Provider/PhotoFavorite.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:new_wallpaper/Component/NotFound.dart';
import 'package:new_wallpaper/theme/style.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_wallpaper/Component/DetailIcon.dart';
import 'package:share/share.dart';
import 'package:new_wallpaper/Component/File_Downloder.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Provider.of<SLocalStorage>(context, listen: false)
              .fetchLoveList(),
          builder: (ctx, snap) => snap.connectionState ==
                  ConnectionState.waiting
              ? Spinner()
              : Consumer<SLocalStorage>(
                  builder: (ctx, love, _) => love.courseList.isEmpty
                      ? NotFoundScreen()
                      : new StaggeredGridView.countBuilder(
                          itemCount: love.courseList.length,
                          staggeredTileBuilder: (i) =>
                              StaggeredTile.count(2, i.isEven ? 3.5 : 2.8),
                          mainAxisSpacing: 0.0,
                          crossAxisSpacing: 0.0,
                          crossAxisCount: 4,
                          itemBuilder: (BuildContext context, i) => Stack(
                            alignment: Alignment.topRight,
                            fit: StackFit.expand,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => DetailFavoriteWidget(
                                          image: love.courseList[i])));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.network(
                                    love.courseList[i],
                                    fit: BoxFit.cover,
                                    // repeat: ImageRepeat.noRepeat,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: AppTheme.black4,
                                      borderRadius: BorderRadius.circular(60)),
                                  child: GestureDetector(
                                      onTap: () {
                                        if (love.courseList
                                            .contains(love.courseList[i])) {
                                          love.removeCourse(
                                              url: love.courseList[i]);
                                        } else {
                                          love.addToLoveList(
                                              photo: love.courseList[i]);
                                        }
                                      },
                                      child: love.courseList.isEmpty
                                          ? Icon(
                                              Icons.favorite_border,
                                              color: AppTheme.black1,
                                              size: 30,
                                            )
                                          : love.courseList
                                                  .contains(love.courseList[i])
                                              ? Icon(
                                                  Icons.favorite,
                                                  color: AppTheme.green,
                                                  size: 30,
                                                )
                                              : Icon(
                                                  Icons.favorite_border,
                                                  color: AppTheme.black1,
                                                  size: 30,
                                                )),
                                ),
                              )
                            ],
                          ),
                        ))),
    );
  }
}

class DetailFavoriteWidget extends StatelessWidget {
  final image;

  DetailFavoriteWidget({this.image});

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.fill)),
        child: Column(
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DetailIcon(
                  onTap: () {
                    Share.share(image, subject: 'NewPaper');
                  },
                  text: language.words['share'],
                  icon: Icon(
                    Icons.share_outlined,
                    size: 30,
                    color: Colors.grey[300],
                  ),
                ),
                FileDownloadWidget(url: image),
                FutureBuilder(
                  future: Provider.of<SLocalStorage>(context, listen: false)
                      .fetchLoveList(),
                  builder: (ctx, snap) =>
                      snap.connectionState == ConnectionState.waiting
                          ? Center(child: CircularProgressIndicator())
                          : DetailIcon(
                              text: language.words['favorite'],
                              bgColor: AppTheme.green,
                              icon: Consumer<SLocalStorage>(
                                builder: (ctx, love, _) => GestureDetector(
                                  onTap: () {
                                    if (love.courseList.contains(image)) {
                                      love.removeCourse(url: image);
                                    } else {
                                      love.addToLoveList(photo: image);
                                    }
                                  },
                                  child: love.courseList.isEmpty
                                      ? Icon(
                                          Icons.favorite_border,
                                          color: AppTheme.black2,
                                          size: 30,
                                        )
                                      : love.courseList.contains(image)
                                          ? Icon(
                                              Icons.favorite,
                                              color: AppTheme.black2,
                                              size: 30,
                                            )
                                          : Icon(
                                              Icons.favorite_border,
                                              color: AppTheme.black2,
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
    );
  }
}
