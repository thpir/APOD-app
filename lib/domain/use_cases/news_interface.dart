import 'package:apod/domain/models/news_article.dart';

abstract class NewsInterface {
  Future<List<NewsArticle>> searchArticles(List<String> keywords);
}
