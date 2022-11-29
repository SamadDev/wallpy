import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/spiner.gif",
          height: 130,
          width: 130,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
