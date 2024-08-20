import 'package:flutter/material.dart';

class HomeScreenErrorView extends StatelessWidget {
  final String errorMessage;
  final Function callback;
  const HomeScreenErrorView(
      {this.errorMessage = 'Failed to load APOD', required this.callback, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(errorMessage),
          const SizedBox(height: 20,),
          IconButton(onPressed: () {
            callback();
          }, icon: const Icon(Icons.refresh))
        ],
      )
    );
  }
}
