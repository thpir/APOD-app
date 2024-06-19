import 'package:apod/models/apod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Apod', () {
    test('fromJson creates an Apod object with the correct properties', () {
      final json = {
        'title': 'Amazing Space Photo',
        'date': '2024-06-14',
        'explanation': 'A beautiful explanation of the photo',
        'url': 'https://example.com/image.jpg',
        'media_type': 'image',
      };

      final apod = Apod.fromJson(json);

      expect(apod.title, json['title']);
      expect(apod.date, json['date']);
      expect(apod.explanation, json['explanation']);
      expect(apod.url, json['url']);
      expect(apod.mediaType, json['media_type']);
    });

    test('throws an error for invalid JSON', () {
      final invalidJson = {'not': 'a', 'valid': 'json'};

      expect(() => Apod.fromJson(invalidJson), throwsFormatException);
    });
  });
}
