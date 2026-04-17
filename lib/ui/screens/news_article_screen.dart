import 'package:apod/domain/models/news_article.dart';
import 'package:apod/ui/features/news/widgets/news_article_view.dart';
import 'package:flutter/material.dart';

class NewsArticleScreen extends StatelessWidget {
  static const routeName = '/news/article';

  const NewsArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as NewsArticleScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          args.article.sourceName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: NewsArticleView(article: args.article),
          ),
        ),
      ),
    );
  }
}

class NewsArticleScreenArguments {
  final NewsArticle article;

  NewsArticleScreenArguments({required this.article});
}
