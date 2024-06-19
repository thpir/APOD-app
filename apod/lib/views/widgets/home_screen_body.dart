import 'package:apod/services/apod_service.dart';
import 'package:apod/utils/home_widget_helper.dart';
import 'package:apod/views/widgets/home_screen_error_view.dart';
import 'package:apod/views/widgets/home_screen_result_view.dart';
import 'package:flutter/material.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final ApodService apodService = ApodService();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: FutureBuilder(
        future: apodService.getAPOD(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final apod = snapshot.data;
              if (apod != null) {
                if (apod.mediaType == 'image') {
                  HomeWidgetHelper().updateWidget(apod);
                }
                return HomeScreenResultView(result: apod);
              } else {
                return const HomeScreenErrorView();
              }         
            } else {
              return const HomeScreenErrorView();
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const HomeScreenErrorView();
          }
        },
      ),
    );
  }
}
