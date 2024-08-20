import 'package:apod/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'APOD app',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        ChangeNotifierProvider<NotificationService>(
          create: (context) => NotificationService(),
          child: Consumer<NotificationService>(
            builder: (context, notificationService, _) {
              return IconButton(
                icon: notificationService.dailyNotificationScheduled ? const Icon(Icons.notifications) : const Icon(Icons.notifications_off),
                onPressed: () {
                  notificationService.dailyNotificationScheduled
                      ? notificationService.cancelDailyNotification()
                      : notificationService.scheduleDailyNotification();
                },
              );
            }
          ),
        ),],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
