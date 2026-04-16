import 'package:apod/data/repositories/notification_repository.dart';
import 'package:apod/ui/features/apod/widgets/apod_view.dart';
import 'package:apod/ui/features/notification_button/widgets/notification_button_view.dart';
import 'package:apod/ui/providers/apod_provider.dart';
import 'package:apod/ui/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApodScreen extends StatelessWidget {
  static const routeName = '/apod';

  const ApodScreen({super.key});

  Future<void> _openDatePicker(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1995, 6, 16),
      lastDate: DateTime.now(),
    );
    if (picked != null && context.mounted) {
      await context.read<ApodProvider>().fetchApodByDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'APOD',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search by date',
            onPressed: () async {
              await _openDatePicker(context);
            },
          ),
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
