import 'package:apod/domain/models/apod.dart';

class ApodApi {
  static Apod toDomain(Map<String, dynamic> json) {
    return Apod(
      title: json['title'] as String,
      date: json['date'] as String,
      explanation: json['explanation'] as String,
      url: json['url'] as String?,
      mediaType: json['media_type'] as String,
    );
  }
}
