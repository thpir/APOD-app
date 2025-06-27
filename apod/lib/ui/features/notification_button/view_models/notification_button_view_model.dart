import 'package:apod/data/repositories/notification_repository.dart';
import 'package:flutter/material.dart';
import 'package:apod/domain/models/notification.dart' as model;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';

class NotificationButtonViewModel extends ChangeNotifier {
  final NotificationRepository _notificationRepository;
  late model.Notification _dailyNotification;

  NotificationButtonViewModel({NotificationRepository? notificationRepository})
      : _notificationRepository = notificationRepository ??
            NotificationRepository(FlutterLocalNotificationsPlugin()) {
    _dailyNotification = model.Notification(
        notificationId: 0,
        channelId: 'daily_apod_notif',
        channelName: 'Daily notification',
        channelDescription:
            'Daily notification to inform you about the latest APOD',
        title: 'Astronomy Picture of the Day',
        bodyText: 'Check out the latest APOD',
        isScheduled: false);
    _checkPendingNotifications();
  }

  bool get isNotificationScheduled => _dailyNotification.isScheduled;

  Future<void> _checkPendingNotifications() async {
    _dailyNotification = _dailyNotification.updateScheduled(
        await _notificationRepository
            .checkIfNotificationScheduled(_dailyNotification));
    notifyListeners();
  }

  Future<void> toggleNotificationButtonPressed() async {
    if (_dailyNotification.isScheduled) {
      Logger().d('Cancelling daily notification');
      await _notificationRepository
          .cancelNotification(_dailyNotification.notificationId);
      _dailyNotification = _dailyNotification.updateScheduled(false);
    } else {
      Logger().d('Scheduling daily notification');
      await _notificationRepository.scheduleNotification(_dailyNotification);
      _dailyNotification = _dailyNotification.updateScheduled(true);
    }
    notifyListeners();
  }
}
