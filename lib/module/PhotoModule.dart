import 'package:flutter/material.dart';

class PixelModel with ChangeNotifier {
  List<Photos>? photos;
  String moreImage = '';
  int? total;

  PixelModel({this.photos, this.total});

  PixelModel.fromJson(json) {
    total = json['total_results'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
  }
}

class Photos {
  String? avgColor;
  Src? src;

  Photos({
    this.avgColor,
    this.src,
  });

  Photos.fromJson(json) {
    avgColor = json['avg_color'];
    src = Src.fromJson(json['src']);
  }
}

class Src {
  String? original;
  String? large2x;
  String? large;
  String? medium;
  String? small;
  String? portrait;
  String? landscape;
  String? tiny;

  Src(
      {this.original,
        this.large2x,
        this.large,
        this.medium,
        this.small,
        this.portrait,
        this.landscape,
        this.tiny});

  Src.fromJson(json) {
    original = json['original'];
    large2x = json['large2x'];
    large = json['large'];
    medium = json['medium'];
    small = json['small'];
    portrait = json['portrait'];
    landscape = json['landscape'];
    tiny = json['tiny'];
  }
}
