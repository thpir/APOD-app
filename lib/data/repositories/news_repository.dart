import 'package:apod/data/services/news_api_service.dart';
import 'package:apod/domain/models/news_article.dart';
import 'package:apod/domain/use_cases/news_interface.dart';

class NewsRepository implements NewsInterface {
  final NewsApiService _service;

  NewsRepository({NewsApiService? service})
      : _service = service ?? NewsApiService();

  @override
  Future<List<NewsArticle>> searchArticles(List<String> keywords) {
    return _service.searchArticles(keywords);
  }
}
