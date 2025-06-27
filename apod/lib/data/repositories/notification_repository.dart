import 'dart:io';

import 'package:apod/domain/interfaces/notification_interface.dart';
import 'package:apod/domain/models/notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/web.dart';

class NotificationRepository implements NotificationInterface {
  final FlutterLocalNotificationsPlugin _flutterPlugin;

  NotificationRepository(FlutterLocalNotificationsPlugin? flutterPlugin)
      : _flutterPlugin = flutterPlugin ?? FlutterLocalNotificationsPlugin() {
    _initNotificationsPlugin();
  }

  @override
  Future<void> cancelNotification(int id) async {
    await _flutterPlugin.cancel(id);
  }

  @override
  Future<void> scheduleNotification(Notification notification) async {
    if (await _canScheduleNotifications()) {
      Logger().d('Scheduling notification with id: ${notification.notificationId}');
      await _flutterPlugin.periodicallyShow(
        notification.notificationId,
        notification.title,
        notification.bodyText,
        RepeatInterval.daily,
        _notificationDetails(notification),
        androidScheduleMode: AndroidScheduleMode.alarmClock);
    } else {
      throw Exception('Notification permissions not granted');
    }
  }

  Future<bool> _canScheduleNotifications() async {
    bool? notificationPermissions;
    if (Platform.isIOS) {
      notificationPermissions = await _flutterPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      return notificationPermissions ?? false;
    } else {
      final AndroidFlutterLocalNotificationsPlugin androidPlugin =
        AndroidFlutterLocalNotificationsPlugin();
      var scheduleExactAlarms =
          await androidPlugin.requestExactAlarmsPermission();
      var showNotifications =
          await androidPlugin.requestNotificationsPermission();
      if (scheduleExactAlarms == true && showNotifications == true) {
        notificationPermissions = true;
      } 
      Logger().d('Notification permissions for android granted: ${notificationPermissions ??  false}');
      return notificationPermissions ?? false;
    }
  }

  NotificationDetails _notificationDetails(Notification notification) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        notification.channelId,
        notification.channelName,
        importance: Importance.max,
        priority: Priority.high,
        channelDescription: notification.channelDescription,
        icon: '@mipmap/ic_launcher',
      ),
    );
  }

  @override
  Future<bool> checkIfNotificationScheduled(Notification notification) async{
    List<PendingNotificationRequest> pendingNotificationRequests =
        await _flutterPlugin.pendingNotificationRequests();
    if (pendingNotificationRequests.isNotEmpty) {
      for (PendingNotificationRequest pendingNotificationRequest
          in pendingNotificationRequests) {
        if (pendingNotificationRequest.id == notification.notificationId) {
          return true;
        }
      }
    }
    return false;
  }

  Future<void> _initNotificationsPlugin() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _flutterPlugin.initialize(
      initializationSettings,
    );
  }
}
