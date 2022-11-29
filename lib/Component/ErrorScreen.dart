import 'package:flutter/material.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:provider/provider.dart';

class ErrorScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final language=Provider.of<Language>(context,listen:false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Icon(
            Icons.error_outline,
            color: Theme.of(context).buttonColor,
            size: 35,
          ),
        ),
        SizedBox(height: 10,),
        Text(
          language.words['error'],
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }
}
