import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL({ url,  context,  title}) async {
  if (await canLaunch(url,)) {
    await launch(url);
  } else {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(title, textAlign: TextAlign.right),
        actions: <Widget>[
          TextButton(
            child: Text('گەرانەوە'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
