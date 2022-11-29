import 'package:new_wallpaper/Provider/ShowToolTip.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class ToolTipWidget extends StatelessWidget {
  final onPress;
  ToolTipWidget({this.onPress});
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return Consumer<IsShow>(
      builder: (ctx, show, _) => AlertDialog(
        actions: [
          Center(
              child: TextButton(
                onPressed: onPress,
                  child: Text(language.words['show'])))
        ],
        contentPadding: EdgeInsets.zero,
        content: Container(
          height: 500,
          width: 230,
          child: Column(
            children: [
              Expanded(
                  child: Image.asset(
                    'assets/images/up.gif',
                    fit: BoxFit.fill,
                  )),
              Expanded(
                  child: Image.asset(
                    'assets/images/down.gif',
                    fit: BoxFit.fill,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
