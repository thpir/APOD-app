import 'package:apod/data/services/notification_service.dart';
import 'package:apod/domain/models/notification.dart';
import 'package:apod/domain/use_cases/notification_interface.dart';
import 'package:logger/web.dart';

class NotificationRepository implements NotificationInterface {
  final NotificationService _service;

  NotificationRepository({NotificationService? service})
      : _service = service ?? NotificationService();

  @override
  Future<void> cancelNotification(int id) async {
    await _service.cancel(id);
  }

  @override
  Future<void> scheduleNotification(Notification notification) async {
    if (!await _service.requestPermissions()) {
      throw Exception('Notification permissions not granted');
    }
    Logger().d('Scheduling notification with id: ${notification.notificationId}');
    await _service.scheduleDaily(
      id: notification.notificationId,
      title: notification.title,
      body: notification.bodyText,
      channelId: notification.channelId,
      channelName: notification.channelName,
      channelDescription: notification.channelDescription,
    );
  }

  @override
  Future<bool> checkIfNotificationScheduled(Notification notification) async {
    return _service.isPending(notification.notificationId);
  }
}
