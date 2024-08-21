import 'dart:convert';

import 'package:apod/models/apod.dart';
import 'package:apod/env/env.dart';
import 'package:http/http.dart' as http;

class ApodService {
  Future<Apod> getAPOD() async {
    final response = await http.get(
        Uri.parse('https://api.nasa.gov/planetary/apod?api_key=${Env.key1}'));
    if (response.statusCode == 200) {
      try {
        return Apod.fromJson(jsonDecode(response.body));
      } catch (e) {
        rethrow;
      }
    } else {
      throw Exception('Failed to load APOD');
    }
  }
}
