import 'package:apod/data/repositories/apod_api_repository.dart';
import 'package:apod/data/repositories/image_downloader_repository.dart';
import 'package:apod/ui/features/apod/view_model/apod_view_model.dart';
import 'package:apod/ui/features/apod/widgets/apod_screen.dart';
import 'package:apod/ui/features/apod_image_detail/view_model/apod_image_detail_view_model.dart';
import 'package:apod/ui/features/apod_image_detail/widgets/apod_image_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apodRepository = ApodApiRepository();
    final imageDownloaderRepository = ImageDownloaderRepository();

    return MaterialApp(
      home: ChangeNotifierProvider(
          create: (context) => ApodViewModel(apodRepository: apodRepository),
          child: const ApodScreen()),
      routes: {
        ApodImageDetailScreen.routeName: (context) => Provider(
              create: (context) => ApodImageDetailViewModel(
                  imageDownloaderRepository: imageDownloaderRepository),
              child: const ApodImageDetailScreen(),
            ),
      },
    );
  }
}
