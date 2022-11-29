class QuoteModule {
  String? text;
  String ?author;

  QuoteModule({required this.text, required this.author});

  QuoteModule.fromJson( json) {
    text = json['text'];
    author = json['author'];
  }
}

