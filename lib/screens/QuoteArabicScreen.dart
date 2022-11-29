import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_wallpaper/Component/CopyToast.dart';
import 'package:new_wallpaper/Component/DetailIcon.dart';
import 'package:new_wallpaper/Provider/LocalQuote.dart';
import 'package:new_wallpaper/Provider/QuoteFavorite.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:new_wallpaper/theme/style.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:clipboard/clipboard.dart';


class QuoteArabicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quote = Provider.of<Quote>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: PageView.builder(
            physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            scrollDirection: Axis.vertical,
            itemCount: quote.arabicQuote.length,
            itemBuilder: (ctx, i) =>
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: Theme
                                .of(context)
                                .buttonColor
                                .withOpacity(0.3),
                            width: 1),
                      )),
                  margin: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Image.asset(
                    'assets/images/pen.png',
                    color: Theme
                        .of(context)
                        .buttonColor
                        .withOpacity(0.5),
                    height: 40,
                  ),
                  Text(
                    "\"${quote.arabicQuote[i].text.toString()}\"",
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontFamily: 'Sarchia_Halab'),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    color: AppTheme.green.withOpacity(0.2),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      quote.arabicQuote[i].author.toString(),
                      textAlign: TextAlign.center,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline6,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DetailIcon(
                        onTap: () {
                          Share.share(quote.arabicQuote[i].text.toString(),
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
                          FlutterClipboard.copy(
                              quote.quoteList[i].text.toString());
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
                                onTap: () {
                                  if (quoteFav.quoteList
                                      .contains(quote.arabicQuote[i].text)) {
                                    quoteFav.removeQuote(
                                        quote: quote.arabicQuote[i].text);
                                  } else {
                                    quoteFav.addQuote(
                                      quote: quote.arabicQuote[i].text,
                                    );
                                  }
                                },
                                child: quoteFav.quoteList.isEmpty
                                    ? Icon(
                                  Icons.favorite_border,
                                  color: AppTheme.black2,
                                  size: 30,
                                )
                                    : quoteFav.quoteList
                                    .contains(quote.arabicQuote[i].text)
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
                    ],
                  ),

                    ],
                  ),
                ),
          )),
    );
  }
}
