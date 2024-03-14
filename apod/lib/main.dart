import 'package:apod/services/apod_service.dart';
import 'package:apod/views/full_screen.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final ApodService apodService = ApodService();
  late YoutubePlayerController controller;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'APOD app',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: FutureBuilder(
            future: apodService.getAPOD(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final apod = snapshot.data;
                  if (apod!.mediaType == 'video') {
                    var youtubeId = YoutubePlayer.convertUrlToId(apod.url);
                    controller = YoutubePlayerController(
                      initialVideoId: youtubeId!,
                      flags: const YoutubePlayerFlags(
                        autoPlay: false,
                        mute: true,
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(apod.title,
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 8.0),
                          Text(apod.date,
                              style: Theme.of(context).textTheme.titleSmall),
                          const SizedBox(height: 8.0),
                          apod.mediaType == 'image'
                              ? Stack(
                                  children: [
                                    Image.network(apod.url),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IconButton.filled(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) => FullScreen(
                                                    imageUrl: apod.url),
                                              ));
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.black54),
                                            ),
                                            icon: const Icon(
                                              Icons.fullscreen,
                                              color: Colors.white,
                                            )),
                                      ),
                                    )
                                  ],
                                )
                              : YoutubePlayer(controller: controller),
                          const SizedBox(height: 8.0),
                          Text(apod.explanation,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(child: Text('Failed to load APOD'));
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(child: Text('Failed to load APOD'));
              }
            },
          ),
        ),
      ),
    );
  }
}
