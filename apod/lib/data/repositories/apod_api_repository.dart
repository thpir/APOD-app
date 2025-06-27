import 'dart:convert';

import 'package:apod/data/models/apod_api.dart';
import 'package:apod/domain/models/apod.dart';
import 'package:apod/domain/interfaces/apod_interface.dart';
import 'package:apod/env/env.dart';
import 'package:http/http.dart' as http;

class ApodApiRepository implements ApodInterface {
  final http.Client _client;
  final String apiKey = Env.key1;

  ApodApiRepository({http.Client? client})
      : _client = client ?? http.Client();

  @override
  Future<Apod> fetchApod() async {
    final response = await _client
        .get(Uri.parse('https://api.nasa.gov/planetary/apod?api_key=$apiKey'));
    if (response.statusCode == 200) {
      return ApodApi.toDomain(json.decode(response.body));
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
  }
}
