import 'package:apod/ui/features/news/widgets/news_keywords_view.dart';
import 'package:flutter/material.dart';

class NewsKeywordsScreen extends StatelessWidget {
  static const routeName = '/news/keywords';
  const NewsKeywordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit keywords',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: const NewsKeywordsView(),
          ),
        ),
      ),
    );
  }
}
