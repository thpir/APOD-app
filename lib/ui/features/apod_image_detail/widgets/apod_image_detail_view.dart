import 'package:flutter/material.dart';

class ApodImageDetailView extends StatelessWidget {
  const ApodImageDetailView({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(child: Image.network(imageUrl)),
    );
  }
}
