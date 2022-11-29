import 'package:flutter/material.dart';

class DetailIcon extends StatelessWidget {
  final  icon;
  final  text;
  final  bgColor;
  final onTap;

  DetailIcon(
      {this.text ,
      this.icon ,
      this.bgColor = Colors.grey,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.all(8),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: this.bgColor),
            child:icon
          ),
          Text(
            this.text,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
