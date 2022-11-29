import 'package:flutter/material.dart';
import 'package:new_wallpaper/Component/SearchEmpty.dart';
import 'package:new_wallpaper/Component/VideoPlayer.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:new_wallpaper/Provider/Video.dart';
import 'package:new_wallpaper/theme/style.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchVideo extends StatefulWidget {
  @override
  _SearchVideoState createState() => _SearchVideoState();
}

class _SearchVideoState extends State<SearchVideo> {
  final text = TextEditingController();
  String value = '';

  Widget build(BuildContext context) {
    final isLoading = Provider.of<Video>(context);
    int _index = 1;
    final data = Provider.of<Video>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).buttonColor,),
        backgroundColor: Theme.of(context).cardColor,
        actions: [
          Container(
            width: 300,
            child: TextField(
              textInputAction: TextInputAction.search,
              controller: text,
              style: Theme.of(context).textTheme.bodyText1,
              onSubmitted: (value) async {
                await Provider.of<Video>(context, listen: false).search(
                  _index,
                  remove: false,
                  category: text.text,
                );
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 17),
                border: InputBorder.none,
                suffixIcon: CloseButton(
                  onPressed: () {
                    text.clear();
                  },
                  color: Theme.of(context).buttonColor,
                ),
                hintStyle: Theme.of(context).textTheme.headline4,
                hintText: language.words['search to video'],
              ),
            ),
          )
        ],
      ),
      body: data.isNull
          ? Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoading.isSearch
                        ? Center(child: CircularProgressIndicator())
                        : Container(
                            height: 1000,
                            child: Consumer<Video>(
                                builder: (ctx, video, _) => LazyLoadScrollView(
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
                                        video.search(
                                          _index,
                                          remove: true,
                                          category: text.text,
                                        );
                                      },
                                      child: StaggeredGridView.countBuilder(
                                        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                        itemCount:
                                            video.searchModule!.videos.length,
                                        staggeredTileBuilder: (i) =>
                                            StaggeredTile.count(
                                                (i % 7 == 0) ? 2 : 1,
                                                (i % 7 == 0) ? 2 : 1),
                                        mainAxisSpacing: 2.0,
                                        crossAxisSpacing: 2.0,
                                        crossAxisCount: 3,
                                        itemBuilder: (ctx, i) =>
                                            GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        VideoPlayerScreen(
                                                          module: video.searchModule,
                                                          index: video.searchModule!.videos.indexOf(video.searchModule!.videos[i]),
                                                        ),),);
                                          },
                                          child: Stack(
                                            fit: StackFit.expand,
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        width: 10,
                                                        color:
                                                            AppTheme.black4)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: CachedNetworkImage(
                                                    imageUrl: video
                                                        .searchModule!
                                                        .videos[i]
                                                        .image
                                                        .toString(),
                                                    fit: BoxFit.fill,
                                                    placeholder: (ctx, snap) =>
                                                        Opacity(
                                                            opacity: 0.1,
                                                            child: Image.asset(
                                                                'assets/images/walpy.jpg',
                                                                fit: BoxFit
                                                                    .cover)),
                                                    // repeat: ImageRepeat.noRepeat,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  Icons.play_circle_fill,
                                                  color: AppTheme.green,
                                                  size: 45,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                          ),
                  ],
                ),
              ),
            )
          : SearchEmpty(),
    );
  }
}
