import 'package:apod/domain/models/notification.dart';

abstract class NotificationInterface {
  Future<void> cancelNotification(int id);

  Future<void> scheduleNotification(Notification notification);

  Future<bool> checkIfNotificationScheduled(Notification notification);
}