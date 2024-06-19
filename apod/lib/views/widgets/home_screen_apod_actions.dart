import 'package:apod/views/screens/full_screen.dart';
import 'package:flutter/material.dart';

class HomeScreenApodActions extends StatelessWidget {
  const HomeScreenApodActions({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton.filled(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  FullScreen(imageUrl: url),
            ));
          },
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(Colors.black54),
          ),
          icon: const Icon(
            Icons.fullscreen,
            color: Colors.white,
          )),
    );
  }
}