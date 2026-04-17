import 'package:apod/domain/models/news_article.dart';
import 'package:apod/ui/core/widgets/cosmos_waiting_indicator.dart';
import 'package:apod/ui/providers/news_provider.dart';
import 'package:apod/ui/screens/news_article_screen.dart';
import 'package:apod/ui/screens/news_keywords_screen.dart';
import 'package:apod/utils/month.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, provider, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              _KeywordsHeader(provider: provider),
              const shadcn.Divider(),
              FutureBuilder<List<NewsArticle>>(
                future: provider.articlesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CosmosWaitingIndicator(
                        color: Theme.of(context).colorScheme.primary,
                        size: 60,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Failed to load articles.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }
                  final articles = snapshot.data ?? [];
                  if (articles.isEmpty) {
                    return Center(
                      child: Text(
                        'No articles found.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }
                  return Column(
                    spacing: 8,
                    children: articles
                        .map((a) => _ArticleTile(article: a))
                        .toList(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _KeywordsHeader extends StatelessWidget {
  final NewsProvider provider;
  const _KeywordsHeader({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Keywords',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            shadcn.Button.outline(
              onPressed: () => Navigator.pushNamed(
                context,
                NewsKeywordsScreen.routeName,
              ),
              leading: const Icon(Icons.edit_outlined, size: 16),
              child: const Text('Edit'),
            ),
          ],
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: provider.selectedKeywords
              .map((keyword) => shadcn.Chip(
                    style: shadcn.ButtonVariance.secondary,
                    child: Text(keyword.keyword),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _ArticleTile extends StatelessWidget {
  final NewsArticle article;
  const _ArticleTile({required this.article});

  @override
  Widget build(BuildContext context) {
    return shadcn.Card(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          NewsArticleScreen.routeName,
          arguments: NewsArticleScreenArguments(article: article),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (article.urlToImage != null)
                SizedBox(
                  width: 110,
                  child: Image.network(
                    article.urlToImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 4,
                    children: [
                      Text(
                        article.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${article.sourceName} · ${Month.formatDate(article.publishedAt)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

