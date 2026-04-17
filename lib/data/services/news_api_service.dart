import 'dart:convert';

import 'package:apod/data/models/news_article_api.dart';
import 'package:apod/domain/models/news_article.dart';
import 'package:apod/env/env.dart';
import 'package:http/http.dart' as http;

class NewsApiService {
  final http.Client _client;
  final String _apiKey;

  static const _baseUrl = 'https://newsapi.org/v2/everything';

  NewsApiService({http.Client? client, String? apiKey})
      : _client = client ?? http.Client(),
        _apiKey = apiKey ?? Env.newsApiKey;

  Future<List<NewsArticle>> searchArticles(List<String> keywords) async {
    if (keywords.isEmpty) {
      keywords = ['space', 'astronomy'];
    }
    final query = keywords.map(Uri.encodeComponent).join(' OR ');
    final uri = Uri.parse('$_baseUrl?q=$query&sortBy=relevancy&pageSize=20&apiKey=$_apiKey');

    final response = await _client.get(uri).timeout(
      const Duration(seconds: 30),
      onTimeout: () => throw Exception('Request timed out'),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as Map<String, dynamic>;
      final articles = body['articles'] as List<dynamic>;
      return articles
          .map((a) => NewsArticleApi.toDomain(a as Map<String, dynamic>))
          .toList();
    } else {
      final body = json.decode(response.body) as Map<String, dynamic>;
      throw Exception('NewsAPI error: ${body['message']}');
    }
  }
}
