import 'package:apod/ui/core/widgets/messages.dart';
import 'package:apod/ui/features/notification_button/view_models/notification_button_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationButtonView extends StatelessWidget {
  const NotificationButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<NotificationButtonViewModel>();
    final read = context.read<NotificationButtonViewModel>();
    return IconButton(
        onPressed: () async {
          try {
            await read.toggleNotificationButtonPressed();
          } catch (e) {
            if (context.mounted) {
              showErrorSnackbar('An error occured: $e', context);
            }
          }
        },
        icon: Icon(watch.isNotificationScheduled
            ? Icons.notifications_active
            : Icons.notifications_off));
  }
}
