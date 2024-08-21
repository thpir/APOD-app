import 'package:flutter/material.dart';
//import 'package:lottie/lottie.dart';

class HomeScreenWaitingView extends StatelessWidget {
  const HomeScreenWaitingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator());
  }
}