import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:new_wallpaper/Component/DetailIcon.dart';
import 'package:new_wallpaper/Component/File_Downloder.dart';
import 'package:new_wallpaper/Component/ToolTipWidget.dart';
import 'package:new_wallpaper/Provider/ShowToolTip.dart';
import 'package:new_wallpaper/module/VideoModule.dart';
import 'package:new_wallpaper/theme/style.dart';
import 'package:video_player/video_player.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';
import 'package:new_wallpaper/Provider/VideoFavorite.dart';
import 'package:new_wallpaper/localization/language.dart';

class VideoWidget extends StatefulWidget {
  final VideoPlayerController videoPlayerController;

  VideoWidget({
    required this.videoPlayerController,
  });

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      customControls: Center(),
        videoPlayerController: widget.videoPlayerController,
        looping: false,
        allowedScreenSleep: true,
        allowPlaybackSpeedChanging: true,
        autoPlay: true,
        showControls: true,
        // showOptions: true,

        aspectRatio: 1.4,
        allowFullScreen: true,
        allowMuting: true,
        autoInitialize: true);
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }

  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final VideosModule? module;
  final index;

  VideoPlayerScreen({this.module, this.index});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: widget.index);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> callFunction() async {
    Provider.of<IsShow>(context, listen: false).fetchIsShow();
    Provider.of<LocalVideoFav>(context, listen: false).fetchVideoFavorite();
  }

  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).buttonColor,),
          backgroundColor: Theme.of(context).cardColor,
          elevation: 0,
        ),
        body: FutureBuilder(
            future: callFunction(),
            builder: (ctx, snap) => snap.connectionState ==
                    ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<IsShow>(
                    builder: (ctx, show, _) => PageView.builder(
                      itemCount: widget.module!.videos.length,
                      scrollDirection: Axis.vertical,
                      controller: controller,
                      itemBuilder: (ctx, i) =>  Column(
                              children: [
                                SizedBox(
                                  height: 530,
                                  child:show.showVideo
                                      ? ToolTipWidget(
                                    onPress: () {
                                      show.setIsShowVideo();
                                    },
                                  )
                                      : VideoWidget(
                                    videoPlayerController:
                                        VideoPlayerController.network(widget
                                            .module!
                                            .videos[i]
                                            .videoFiles![5]
                                            .link
                                            .toString()),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    DetailIcon(
                                      onTap: () {
                                        Share.share(
                                            widget.module!.videos[i]
                                                .videoFiles![2].link
                                                .toString(),
                                            subject: 'NewPaper');
                                      },
                                      text: language.words['share'],
                                      icon: Icon(
                                        Icons.share_outlined,
                                        size: 30,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                    FileDownloadWidget(
                                        url: widget.module!.videos[i]
                                            .videoFiles![2].link),
                                    DetailIcon(
                                        text: language.words['download'],
                                        bgColor: AppTheme.green,
                                        icon: Consumer<LocalVideoFav>(
                                            builder: (ctx, love, _) =>
                                                GestureDetector(
                                                    onTap: () {
                                                      if (love.videoFavorite
                                                          .contains(widget
                                                              .module!
                                                              .videos[i]
                                                              .videoFiles![5]
                                                              .link)) {
                                                        love.removeVideoFavorite(
                                                            url: widget
                                                                .module!
                                                                .videos[i]
                                                                .videoFiles![5]
                                                                .link,
                                                            picture: widget
                                                                .module!
                                                                .videos[i]
                                                                .image);
                                                      } else {
                                                        love.addVideoFavorite(
                                                            video: widget
                                                                .module!
                                                                .videos[i]
                                                                .videoFiles![5]
                                                                .link,
                                                            picture: widget
                                                                .module!
                                                                .videos[i]
                                                                .image);
                                                      }
                                                    },
                                                    child: love.videoFavorite
                                                            .isEmpty
                                                        ? Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color:
                                                                AppTheme.black2,
                                                            size: 30,
                                                          )
                                                        : love.videoFavorite
                                                                .contains(widget
                                                                    .module!
                                                                    .videos[i]
                                                                    .videoFiles![
                                                                        5]
                                                                    .link)
                                                            ? Icon(
                                                                Icons.favorite,
                                                                color: AppTheme
                                                                    .black2,
                                                                size: 30,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .favorite_border,
                                                                color: AppTheme
                                                                    .black2,
                                                                size: 30,
                                                              ))))
                                  ],
                                )
                              ],
                            ),
                    ),
                  )));
  }
}
