import 'package:apod/domain/models/news_keyword.dart';
import 'package:apod/ui/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

class NewsKeywordsView extends StatelessWidget {
  const NewsKeywordsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, provider, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select keywords',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      Text(
                        '${provider.selectedKeywords.length}/${NewsProvider.maxKeywords}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: provider.isAtLimit
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(width: 8),
                      shadcn.Button.outline(
                        onPressed: provider.selectedKeywords.isEmpty
                            ? null
                            : provider.clearKeywords,
                        child: const Text('Deselect all'),
                      ),
                    ],
                  ),
                ],
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: NewsKeyword.values.map((keyword) {
                  final isSelected =
                      provider.selectedKeywords.contains(keyword);
                  final isDisabled = provider.isAtLimit && !isSelected;
                  return shadcn.Chip(
                    style: isSelected
                        ? shadcn.ButtonVariance.primary
                        : shadcn.ButtonVariance.outline,
                    onPressed: isDisabled
                        ? null
                        : () => provider.toggleKeyword(keyword),
                    child: Text(keyword.keyword),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
