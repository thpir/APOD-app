import 'package:apod/data/repositories/news_repository.dart';
import 'package:apod/data/repositories/shared_prefs_repository.dart';
import 'package:apod/data/services/shared_prefs_service.dart';
import 'package:apod/domain/models/news_article.dart';
import 'package:apod/domain/models/news_keyword.dart';
import 'package:apod/domain/use_cases/news_interface.dart';
import 'package:apod/domain/use_cases/shared_prefs_interface.dart';
import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  static const maxKeywords = 5;

  final NewsInterface _newsRepository;
  final SharedPrefsInterface _sharedPrefsRepository;

  List<NewsKeyword> _selectedKeywords = [];
  List<NewsKeyword> get selectedKeywords => _selectedKeywords;
  bool get isAtLimit => _selectedKeywords.length >= maxKeywords;

  Future<List<NewsArticle>> articlesFuture = Future.value([]);

  NewsProvider({
    NewsInterface? newsRepository,
    SharedPrefsInterface? sharedPrefsRepository,
  })  : _newsRepository = newsRepository ?? NewsRepository(),
        _sharedPrefsRepository =
            sharedPrefsRepository ?? SharedPrefsRepository() {
    _init();
  }

  Future<void> _init() async {
    await _loadSelectedKeywords();
    fetchArticles();
  }

  Future<void> _loadSelectedKeywords() async {
    final stored = await _sharedPrefsRepository.readStringList(
      SharedPrefsService.newsKeywordsKey,
    );

    if (stored.isEmpty) {
      _selectedKeywords = NewsKeyword.values.take(maxKeywords).toList();
    } else {
      _selectedKeywords = stored
          .map((k) => NewsKeyword.values.firstWhere(
                (e) => e.name == k,
                orElse: () => NewsKeyword.space,
              ))
          .toList();
    }
  }

  void fetchArticles() {
    final keywords = _selectedKeywords.map((k) => k.keyword).toList();
    articlesFuture = _newsRepository.searchArticles(keywords);
    notifyListeners();
  }

  Future<void> clearKeywords() => updateSelectedKeywords([]);

  Future<void> toggleKeyword(NewsKeyword keyword) async {
    final updated = List<NewsKeyword>.from(_selectedKeywords);
    if (updated.contains(keyword)) {
      updated.remove(keyword);
    } else if (updated.length < maxKeywords) {
      updated.add(keyword);
    }
    await updateSelectedKeywords(updated);
  }

  Future<void> updateSelectedKeywords(List<NewsKeyword> keywords) async {
    _selectedKeywords = keywords;
    await _sharedPrefsRepository.writeStringList(
      SharedPrefsService.newsKeywordsKey,
      keywords.map((k) => k.name).toList(),
    );
    fetchArticles();
  }
}
