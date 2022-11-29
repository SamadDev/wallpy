import 'package:flutter/material.dart';
import 'package:new_wallpaper/localization/language.dart';

import 'package:provider/provider.dart';

class AboutScreen extends StatelessWidget {
  static const String route = 'AboutScreen';

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).buttonColor,),
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        title: Text(language.words['about'],style: Theme.of(context).textTheme.bodyText1,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 50),
                child: Image.asset(
                  'assets/images/walpy.jpg',
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 85,),
              Text(
                language.words['wal'],
                style: Theme
                    .of(context)
                    .textTheme
                    .headline4,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                language.words['about wal'],
                style: Theme
                    .of(context)
                    .textTheme
                    .subtitle1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
