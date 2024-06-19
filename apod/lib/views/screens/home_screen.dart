import 'package:apod/views/widgets/home_screen_appbar.dart';
import 'package:apod/views/widgets/home_screen_body.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeScreenAppbar(),
      body: HomeScreenBody(),
    );
  }
}