import 'package:apod/domain/models/apod.dart';
import 'package:apod/ui/features/apod/widgets/video_frame.dart';
import 'package:apod/ui/screens/apod_image_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

class ApodResultView extends StatelessWidget {
  const ApodResultView({super.key, required this.apod});

  final Apod apod;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(apod.title, style: Theme.of(context).textTheme.titleMedium),
              shadcn.OutlineBadge(child: Text(apod.date)),
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
      child: shadcn.Button(
        style: const shadcn.ButtonStyle.secondary(
          density: shadcn.ButtonDensity.icon,
        ),
        onPressed: () => Navigator.of(context).pushNamed(
          ApodImageDetailScreen.routeName,
          arguments: ApodImageDetailScreenArguments(imageUrl: imageUrl),
        ),
        child: const Icon(Icons.fullscreen, size: 20),
      ),
    );
  }
}
