import 'package:apod/domain/models/news_article.dart';
import 'package:apod/utils/month.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import 'package:url_launcher/url_launcher.dart';

class NewsArticleView extends StatelessWidget {
  final NewsArticle article;

  const NewsArticleView({super.key, required this.article});

  Future<void> _openUrl() async {
    final uri = Uri.parse(article.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.urlToImage != null)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                article.urlToImage!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                shadcn.OutlineBadge(child: Text(article.sourceName)),
                Text(
                  article.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  [
                    if (article.author != null) article.author!,
                    Month.formatDate(article.publishedAt),
                  ].join(' · '),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const shadcn.Divider(),
                if (article.description != null)
                  Text(
                    article.description!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                if (article.content != null)
                  Text(
                    article.content!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                const SizedBox(height: 4),
                shadcn.Button.outline(
                  onPressed: _openUrl,
                  trailing: const Icon(Icons.open_in_new, size: 16),
                  child: const Text('Read full article'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
