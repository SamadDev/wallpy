import 'package:flutter/material.dart';
import 'package:new_wallpaper/Component/CopyToast.dart';
import 'package:new_wallpaper/Component/DetailIcon.dart';
import 'package:new_wallpaper/Component/NotFound.dart';
import 'package:new_wallpaper/Component/Sipnner.dart';
import 'package:new_wallpaper/Provider/QuoteFavorite.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:new_wallpaper/theme/style.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:clipboard/clipboard.dart';


class FavoriteQuoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return Scaffold(
     
      body: FutureBuilder(
          future: Provider.of<FavQuote>(context, listen: false).fetchQuote(),
          builder: (ctx, snap) => snap.connectionState ==
                  ConnectionState.waiting
              ? Spinner()
              : Consumer<FavQuote>(
                  builder: (ctx, love, _) => love.quoteList.isEmpty
                      ? NotFoundScreen()
                      : new ListView.builder(
                          itemCount: love.quoteList.length,
                          itemBuilder: (BuildContext context, i) => Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppTheme.green.withOpacity(0.1))),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(top:8.0,bottom: 8),
                                  child: Text(
                                    love.quoteList[i],
                                    style:
                                    Theme.of(context).textTheme.headline3,textAlign: TextAlign.center,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    DetailIcon(
                                      onTap: () {
                                        Share.share(
                                            love.quoteList[i],
                                            subject: 'NewPaper');
                                      },
                                      text: language.words['share'],
                                      icon: Icon(
                                        Icons.share_outlined,
                                        size: 30,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                    DetailIcon(
                                      onTap: () {
                                        copyWidget(context);
                                        FlutterClipboard.copy(love.quoteList[i]);
                                      },
                                      text: language.words['copy'],
                                      icon: Icon(
                                        Icons.copy,
                                        size: 30,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                    DetailIcon(
                                        text: language.words['download'],
                                        bgColor: AppTheme.green,
                                        icon: Consumer<FavQuote>(
                                            builder: (ctx, quoteFav, _) =>
                                                GestureDetector(
                                                    onTap: ()  {
                                                      if (love.quoteList
                                                          .contains(love.quoteList[i])) {
                                                        love.removeQuote(
                                                            quote: love.quoteList[i]);
                                                      } else {
                                                        love.addQuote(
                                                            quote: love.quoteList[i]);
                                                      }
                                                    },
                                                    child: quoteFav
                                                        .quoteList.isEmpty
                                                        ? Icon(
                                                      Icons.favorite_border,
                                                      color:
                                                      AppTheme.black2,
                                                      size: 30,
                                                    )
                                                        : quoteFav.quoteList
                                                        .contains(love
                                                        .quoteList[i])
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
                        ))),
    );
  }
}
