class Apod {
  final String title;
  final String date;
  final String explanation;
  final String url;
  final String mediaType;

  Apod(
      {required this.title,
      required this.date,
      required this.explanation,
      required this.url,
      required this.mediaType});

  factory Apod.fromJson(Map<String, dynamic> json) {
    try {
      return Apod(
          title: json['title'],
          date: json['date'],
          explanation: json['explanation'],
          url: json['url'],
          mediaType: json['media_type']);
    } catch (e) {
      throw const FormatException('Error parsing APOD');
    }
  }
}
