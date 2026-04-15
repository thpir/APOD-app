import 'package:apod/data/repositories/apod_api_repository.dart';
import 'package:apod/data/repositories/image_downloader_repository.dart';
import 'package:apod/ui/providers/apod_provider.dart';
import 'package:apod/ui/screens/apod_image_detail_screen.dart';
import 'package:apod/ui/screens/apod_screen.dart';
import 'package:apod/ui/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ApodProvider(
        apodRepository: ApodApiRepository(),
        imageDownloaderRepository: ImageDownloaderRepository(),
      ),
      child: MaterialApp(
        home: const HomeScreen(),
        routes: {
          ApodScreen.routeName: (context) => const ApodScreen(),
          ApodImageDetailScreen.routeName: (context) =>
              const ApodImageDetailScreen(),
        },
      ),
    );
  }
}
