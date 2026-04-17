import 'package:apod/domain/models/news_article.dart';

class NewsArticleApi {
  static const sourceSlug = 'source';
  static const nameSlug = 'name';
  static const authorSlug = 'author';
  static const titleSlug = 'title';
  static const descriptionSlug = 'description';
  static const urlSlug = 'url';
  static const urlToImageSlug = 'urlToImage';
  static const publishedAtSlug = 'publishedAt';
  static const contentSlug = 'content';

  static NewsArticle toDomain(Map<String, dynamic> json) {
    return NewsArticle(
      sourceName: (json[sourceSlug] as Map<String, dynamic>)[nameSlug] as String? ?? '',
      author: json[authorSlug] as String?,
      title: json[titleSlug] as String,
      description: json[descriptionSlug] as String?,
      url: json[urlSlug] as String,
      urlToImage: json[urlToImageSlug] as String?,
      publishedAt: DateTime.parse(json[publishedAtSlug] as String),
      content: json[contentSlug] as String?,
    );
  }
}
