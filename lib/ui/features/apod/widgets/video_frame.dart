import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoFrame extends StatelessWidget {
  const VideoFrame({super.key, required this.url});

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
