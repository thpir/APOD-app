import 'package:apod/data/repositories/notification_repository.dart';
import 'package:apod/ui/features/apod/widgets/apod_view.dart';
import 'package:apod/ui/features/notification_button/widgets/notification_button_view.dart';
import 'package:apod/ui/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApodScreen extends StatelessWidget {
  static const routeName = '/apod';

  const ApodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'APOD',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          ChangeNotifierProvider(
            create: (_) => NotificationProvider(notificationRepository: NotificationRepository()),
            child: const NotificationButtonView(),
          ),
        ],
      ),
      body: const ApodView(),
    );
  }
}
