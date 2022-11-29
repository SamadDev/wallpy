import 'package:flutter/material.dart';

class SearchEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
            'assets/images/s.png',
            color: Theme.of(context).buttonColor,
            height: 120,
            width: 120,
          )),
    );
  }
}
