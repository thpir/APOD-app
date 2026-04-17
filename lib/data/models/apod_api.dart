import 'package:apod/domain/models/apod.dart';

class ApodApi {
  static const titleSlug = 'title';
  static const dateSlug = 'date';
  static const explanationSlug = 'explanation';
  static const urlSlug = 'url';
  static const mediaTypeSlug = 'media_type';

  static Apod toDomain(Map<String, dynamic> json) {
    return Apod(
      title: json[titleSlug] as String,
      date: json[dateSlug] as String,
      explanation: json[explanationSlug] as String,
      url: json[urlSlug] as String?,
      mediaType: json[mediaTypeSlug] as String,
    );
  }
}
