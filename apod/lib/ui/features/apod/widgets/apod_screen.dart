import 'package:apod/domain/models/apod.dart';
import 'package:apod/ui/features/apod/view_model/apod_view_model.dart';
import 'package:apod/ui/features/apod_image_detail/widgets/apod_image_detail_screen.dart';
import 'package:apod/ui/core/helpers/home_widget_helper.dart';
import 'package:apod/ui/core/widgets/error_view.dart';
import 'package:apod/ui/core/widgets/waiting_view.dart';
import 'package:apod/ui/features/notification_button/view_models/notification_button_view_model.dart';
import 'package:apod/ui/features/notification_button/widgets/notification_button_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ApodScreen extends StatelessWidget {
  const ApodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'APOD app',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          ChangeNotifierProvider(
            create: (_) => NotificationButtonViewModel(),
            child: const NotificationButtonView(),
          )
        ],
      ),
      body: FutureBuilder<Apod>(
          future: context.watch<ApodViewModel>().apodFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorView(
                errorMessage:
                    'An error occurred while fetching the APOD. Please try again later.',
                child: IconButton(
                    onPressed: () {
                      context.read<ApodViewModel>().fetchApod();
                    },
                    icon: const Icon(Icons.refresh)),
              );
            } else if (snapshot.hasData) {
              final apod = snapshot.data!;
              if (apod.mediaType == 'image') {
                HomeWidgetHelper().updateWidget(apod);
              }
              return ApodResultView(apod: apod);
            } else {
              return const WaitingView();
            }
          }),
    );
  }
}

class ApodResultView extends StatelessWidget {
  const ApodResultView({
    super.key,
    required this.apod,
  });

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
                    child: ShowApodDetailButton(
                      imageUrl: apod.url!,
                    ),
                  )
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
  const ShowApodDetailButton({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton.filled(
          onPressed: () {
            Navigator.of(context).pushNamed(ApodImageDetailScreen.routeName,
                arguments: imageUrl);
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.black54),
          ),
          icon: const Icon(
            Icons.fullscreen,
            color: Colors.white,
          )),
    );
  }
}

class VideoFrame extends StatelessWidget {
  const VideoFrame({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    final youtubeId = YoutubePlayerController.convertUrlToId(url);
    final controller = YoutubePlayerController.fromVideoId(
      videoId: youtubeId!,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    return YoutubePlayer(controller: controller);
  }
}
