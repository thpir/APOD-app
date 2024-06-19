import 'package:apod/utils/file_saver.dart';
import 'package:flutter/material.dart';

class FullScreen extends StatelessWidget {
  final String imageUrl;
  const FullScreen({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.download_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              FileSaver().saveImage(imageUrl).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(value!),
                  duration: const Duration(seconds: 2),
                ));
              });
            },
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        color: Colors.black,
        child: Center(
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}
