import 'package:apod/services/apod_service.dart';
import 'package:apod/utils/home_widget_helper.dart';
import 'package:apod/views/widgets/home_screen_error_view.dart';
import 'package:apod/views/widgets/home_screen_result_view.dart';
import 'package:apod/views/widgets/home_screen_waiting_view.dart';
import 'package:flutter/material.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final ApodService apodService = ApodService();

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
              // For some reason the data is null
              return HomeScreenErrorView(callback: refresh);
            }
          } else {
            // For some reason no data is returned from the service
            return HomeScreenErrorView(
                callback: refresh,
                errorMessage: "No data returned from the service");
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const HomeScreenWaitingView();
        } else if (snapshot.hasError) {
          // Apod or ApodService trew an error
          return HomeScreenErrorView(
            callback: refresh,
            errorMessage: snapshot.error.toString()
          );
        } else {
          // Something went wrong...
          return HomeScreenErrorView(callback: refresh,);
        }
      },
    );
  }
}
