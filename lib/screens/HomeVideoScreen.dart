import 'package:new_wallpaper/Component/Sipnner.dart';
import 'package:new_wallpaper/Component/VideoPlayer.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:new_wallpaper/Provider/Video.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:new_wallpaper/theme/style.dart';

class HomeVideoScreen extends StatelessWidget {
  final String? category;
  final bool remove;

  HomeVideoScreen({this.category, required this.remove});

  Widget build(BuildContext context) {
    int _index = 1;
    final data = Provider.of<Video>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: data.getVideo(category, _index, remove: remove),
        builder: (ctx, snap) =>
        snap.connectionState == ConnectionState.waiting
            ? Spinner()
            : Consumer<Video>(
          builder: (ctx, video, _) =>
              LazyLoadScrollView(
                onEndOfPage: () {
                  Fluttertoast.showToast(
                      msg: language.words['message'],
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: AppTheme.green,
                      textColor: AppTheme.white,
                      fontSize: 16.0);
                  _index = _index + 1;
                  video.getVideo(category, _index, remove: true);
                },
                child: StaggeredGridView.countBuilder(
                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  itemCount: video.videoModule!.videos.length,
                  staggeredTileBuilder: (i) =>
                      StaggeredTile.count(
                          (i % 7 == 0) ? 2 : 1, (i % 7 == 0) ? 2 : 1),
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                  crossAxisCount: 3,
                  itemBuilder: (ctx, i) =>
                      GestureDetector(
                        onTap: () {
                          // print(video.videoModule!.videos[i].image.toString());
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) =>
                                  VideoPlayerScreen(
                                    module:video.videoModule,
                                    index:video.videoModule!.videos.indexOf(video.videoModule!.videos[i]),
                                  )));
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                  Border.all(
                                      width: 10, color: AppTheme.black4)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  imageUrl: video.videoModule!.videos[i].image
                                      .toString(),
                                  fit: BoxFit.fill,
                                  placeholder: (ctx, snap) =>
                                      Opacity(
                                          opacity: 0.1,
                                          child: Image.asset(
                                              'assets/images/walpy.jpg',
                                              fit: BoxFit.cover)),
                                  // repeat: ImageRepeat.noRepeat,
                                ),
                              ),
                            ),
                            Icon(Icons.play_circle_fill, color: AppTheme.green,
                              size: 45,)
                          ],
                        ),
                      ),
                ),
              ),
        ),
      ),
    );
  }
}
