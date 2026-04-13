import 'package:flutter/material.dart';

class WaitingView extends StatelessWidget {
  const WaitingView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width > MediaQuery.sizeOf(context).height
        ? MediaQuery.sizeOf(context).height * 0.5
        : MediaQuery.sizeOf(context).width * 0.5;
    return Center(
      //child: CircularProgressIndicator(),
      child: Image.asset(
        'assets/animations/solar_system_waiting.gif',
        width: size,
        height: size,
      ),
    );
  }
}