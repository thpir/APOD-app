import 'package:flutter/material.dart';

class FullScreen extends StatelessWidget {
  final String imageUrl;
  const FullScreen({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Center(
              child: Image.network(imageUrl),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton.filled(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black54),
                    ),
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
