import 'package:apod/models/apod.dart';
import 'package:apod/views/widgets/home_screen_apod_actions.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreenResultView extends StatefulWidget {
  final Apod result;
  const HomeScreenResultView({required this.result, super.key});

  @override
  State<HomeScreenResultView> createState() => _HomeScreenResultViewState();
}

class _HomeScreenResultViewState extends State<HomeScreenResultView> {
  late YoutubePlayerController controller;

  @override
  void dispose() {
    super.dispose();
    //controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.result.mediaType == 'video') {
      //var youtubeId = YoutubePlayer.convertUrlToId(widget.result.url);
      var youtubeId = YoutubePlayerController.convertUrlToId(widget.result.url);
      // controller = YoutubePlayerController(
      //   initialVideoId: youtubeId!,
      //   flags: const YoutubePlayerFlags(
      //     autoPlay: false,
      //     mute: true,
      //   ),
      // );
      controller = YoutubePlayerController.fromVideoId(
        videoId: youtubeId!,
        autoPlay: false,
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
        ),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.result.title,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text(widget.result.date,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8.0),
            widget.result.mediaType == 'image'
                ? Stack(
                    children: [
                      Image.network(widget.result.url),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: HomeScreenApodActions(url: widget.result.url),
                      )
                    ],
                  )
                : YoutubePlayer(controller: controller),
            const SizedBox(height: 8.0),
            Text(widget.result.explanation,
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
