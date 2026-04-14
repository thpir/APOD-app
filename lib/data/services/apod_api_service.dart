import 'dart:convert';

import 'package:apod/env/env.dart';
import 'package:http/http.dart' as http;

class ApodApiService {
  final http.Client _client;
  final String _apiKey;

  ApodApiService({http.Client? client, String? apiKey})
      : _client = client ?? http.Client(),
        _apiKey = apiKey ?? Env.key1;

  Future<Map<String, dynamic>> fetchApod() async {
    final response = await _client
        .get(Uri.parse('https://api.nasa.gov/planetary/apod?api_key=$_apiKey'))
        .timeout(
          const Duration(seconds: 30),
          onTimeout: () => throw Exception('Request timed out'),
        );
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
  }
}
