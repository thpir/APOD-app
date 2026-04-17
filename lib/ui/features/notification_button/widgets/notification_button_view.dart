import 'package:apod/ui/core/widgets/messages.dart';
import 'package:apod/ui/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

class NotificationButtonView extends StatelessWidget {
  const NotificationButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<NotificationProvider>();
    final read = context.read<NotificationProvider>();
    return shadcn.Button.ghost(
      onPressed: () async {
        try {
          await read.toggleNotificationButtonPressed();
        } catch (e) {
          if (context.mounted) {
            showErrorToast('An error occured: $e', context);
          }
        }
      },
      child: Icon(
        watch.isNotificationScheduled
            ? Icons.notifications_active
            : Icons.notifications_off,
      ),
    );
  }
}
