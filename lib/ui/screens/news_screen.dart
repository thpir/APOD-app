import 'package:apod/ui/features/news/widgets/news_view.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  static const routeName = '/news';
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Space news',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: const NewsView(),
          ),
        ),
      ),
    );
  }
}
