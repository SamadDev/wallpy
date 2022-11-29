import 'package:flutter/material.dart';
import 'package:new_wallpaper/Component/NotFound.dart';
import 'package:new_wallpaper/Component/Sipnner.dart';
import 'package:new_wallpaper/Component/VideoPlayer.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_wallpaper/Component/DetailIcon.dart';
import 'package:new_wallpaper/Component/File_Downloder.dart';
import 'package:new_wallpaper/theme/style.dart';
import 'package:video_player/video_player.dart';
import 'package:share/share.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:new_wallpaper/Provider/VideoFavorite.dart';

class FavoriteVideoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Provider.of<LocalVideoFav>(context, listen: false)
              .fetchVideoFavorite(),
          builder: (ctx, snap) => snap.connectionState ==
                  ConnectionState.waiting
              ? Spinner()
              : Consumer<LocalVideoFav>(
                  builder: (ctx, video, _) => video.videoFavorite.isEmpty
                      ? NotFoundScreen()
                      : StaggeredGridView.countBuilder(
                          itemCount: video.videoFavorite.length,
                          staggeredTileBuilder: (i) =>
                              StaggeredTile.count(  i.isOdd ||i%7!=0? 2: 2, (i % 7 == 0) ? 2 : 3),
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
                                      builder: (ctx) => VideoFaveDetail(
                                          picture: video.videoPicture[i],
                                          url: video.videoFavorite[i])));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.network(
                                    video.videoPicture[i],
                                    fit: BoxFit.cover,
                                    // repeat: ImageRepeat.noRepeat,
                                  ),
                                ),
                              ),
                              Align(alignment: Alignment.center,
                              child:   Icon(Icons.play_arrow_rounded,color: AppTheme.green,size: 45,),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color:AppTheme.black4,
                                      borderRadius: BorderRadius.circular(60)),
                                  child: GestureDetector(
                                      onTap: () {
                                        if (video.videoFavorite
                                            .contains(video.videoFavorite[i])) {
                                          video.removeVideoFavorite(
                                              picture: video.videoPicture[i],
                                              url: video.videoFavorite[i]);
                                        } else {
                                          video.addVideoFavorite(
                                              video: video.videoFavorite[i],picture: video.videoPicture[i]);
                                        }
                                      },
                                      child: video.videoFavorite.isEmpty
                                          ? Icon(
                                              Icons.favorite_border,
                                              color: AppTheme.black1,
                                              size: 30,
                                            )
                                          : video.videoFavorite.contains(
                                                  video.videoFavorite[i])
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


class VideoFaveDetail extends StatelessWidget {
  final url;
  final picture;

  VideoFaveDetail({this.url, this.picture});

  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).buttonColor,),
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 530,
              child: VideoWidget(
                videoPlayerController: VideoPlayerController.network(url),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DetailIcon(
                  onTap: () {
                    Share.share(url, subject: 'NewPaper');
                  },
                  text: language.words['share'],
                  icon: Icon(
                    Icons.share_outlined,
                    size: 30,
                    color: Colors.grey[300],
                  ),
                ),
                FileDownloadWidget(url: url),
                FutureBuilder(
                    future: Provider.of<LocalVideoFav>(context, listen: false)
                        .fetchVideoFavorite(),
                    builder: (ctx, snap) => snap.connectionState ==
                        ConnectionState.waiting
                        ? Center(child: CircularProgressIndicator())
                        : DetailIcon(
                        text: language.words['download'],
                        bgColor: AppTheme.green,
                        icon: Consumer<LocalVideoFav>(
                            builder: (ctx, love, _) => GestureDetector(
                                onTap: () {
                                  if (love.videoFavorite.contains(url)) {
                                    love.removeVideoFavorite(
                                        url: url, picture: picture);
                                  } else {
                                    love.addVideoFavorite(
                                        video: url, picture: picture);
                                  }
                                },
                                child: love.videoFavorite.isEmpty
                                    ? Icon(
                                  Icons.favorite_border,
                                  color: AppTheme.black2,
                                  size: 30,
                                )
                                    : love.videoFavorite.contains(url)
                                    ? Icon(
                                  Icons.favorite,
                                  color: AppTheme.black2,
                                  size: 30,
                                )
                                    : Icon(
                                  Icons.favorite_border,
                                  color: AppTheme.black2,
                                  size: 30,
                                )))))
              ],
            )
          ],
        ),
      ),
    );
  }
}
