import 'package:apod/ui/providers/apod_provider.dart';
import 'package:apod/ui/providers/news_provider.dart';
import 'package:apod/ui/screens/apod_image_detail_screen.dart';
import 'package:apod/ui/screens/apod_screen.dart';
import 'package:apod/ui/screens/home.dart';
import 'package:apod/ui/screens/news_article_screen.dart';
import 'package:apod/ui/screens/news_keywords_screen.dart';
import 'package:apod/ui/screens/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApodProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: shadcn.ShadcnApp(
        theme: const shadcn.ThemeData(
          colorScheme: shadcn.ColorSchemes.darkSlate,
        ),
        home: const HomeScreen(),
        routes: {
          ApodScreen.routeName: (_) => const ApodScreen(),
          ApodImageDetailScreen.routeName: (_) =>
              const ApodImageDetailScreen(),
          NewsScreen.routeName: (_) => const NewsScreen(),
          NewsKeywordsScreen.routeName: (_) => const NewsKeywordsScreen(),
          NewsArticleScreen.routeName: (_) => const NewsArticleScreen(),
        },
      ),
    );
  }
}
