import 'dart:convert';

import 'package:apod/models/apod.dart';
import 'package:apod/env/env.dart';
import 'package:http/http.dart' as http;

class ApodService {
  Future<Apod> getAPOD() async {
    try {
      final response = await http.get(
          Uri.parse('https://api.nasa.gov/planetary/apod?api_key=${Env.key1}'));
      if (response.statusCode == 200) {
        return Apod.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('APOD-service returned status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
