import 'package:apod/domain/models/apod.dart';
import 'package:apod/ui/features/apod/widgets/video_frame.dart';
import 'package:apod/ui/screens/apod_image_detail_screen.dart';
import 'package:flutter/material.dart';

class ApodResultView extends StatelessWidget {
  const ApodResultView({super.key, required this.apod});

  final Apod apod;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(apod.title, style: Theme.of(context).textTheme.titleMedium),
            Text(apod.date, style: Theme.of(context).textTheme.titleSmall),
            if (apod.mediaType == 'image')
              Stack(
                children: [
                  Image.network(apod.url!),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ShowApodDetailButton(imageUrl: apod.url!),
                  ),
                ],
              ),
            if (apod.mediaType == 'video') VideoFrame(url: apod.url!),
            Text(apod.explanation,
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class ShowApodDetailButton extends StatelessWidget {
  const ShowApodDetailButton({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton.filled(
        onPressed: () {
          Navigator.of(context).pushNamed(
            ApodImageDetailScreen.routeName,
            arguments: ApodImageDetailScreenArguments(imageUrl: imageUrl),
          );
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.black54),
        ),
        icon: const Icon(Icons.fullscreen, color: Colors.white),
      ),
    );
  }
}
