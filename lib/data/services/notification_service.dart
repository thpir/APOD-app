import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin;

  NotificationService({FlutterLocalNotificationsPlugin? plugin})
      : _plugin = plugin ?? FlutterLocalNotificationsPlugin() {
    _initialize();
  }

  Future<void> scheduleDaily({
    required int id,
    required String title,
    required String body,
    required String channelId,
    required String channelName,
    required String channelDescription,
  }) async {
    await _plugin.periodicallyShow(
      id,
      title,
      body,
      RepeatInterval.daily,
      _buildDetails(channelId, channelName, channelDescription),
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  Future<void> cancel(int id) async {
    await _plugin.cancel(id);
  }

  Future<bool> isPending(int id) async {
    final pending = await _plugin.pendingNotificationRequests();
    return pending.any((r) => r.id == id);
  }

  Future<bool> requestPermissions() async {
    if (Platform.isIOS) {
      final granted = await _plugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return granted ?? false;
    } else {
      final androidPlugin = AndroidFlutterLocalNotificationsPlugin();
      final exactAlarms = await androidPlugin.requestExactAlarmsPermission();
      final notifications = await androidPlugin.requestNotificationsPermission();
      return exactAlarms == true && notifications == true;
    }
  }

  NotificationDetails _buildDetails(
    String channelId,
    String channelName,
    String channelDescription,
  ) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        importance: Importance.max,
        priority: Priority.high,
        channelDescription: channelDescription,
        icon: '@mipmap/ic_launcher',
      ),
    );
  }

  Future<void> _initialize() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings();
    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: iOS),
    );
  }
}
