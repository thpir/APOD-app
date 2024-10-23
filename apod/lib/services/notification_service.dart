import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _flutterPlugin =
      FlutterLocalNotificationsPlugin();
  // final AndroidFlutterLocalNotificationsPlugin _androidPlugin =
  //     AndroidFlutterLocalNotificationsPlugin();
  // final IOSFlutterLocalNotificationsPlugin _iosPlugin =
  //     IOSFlutterLocalNotificationsPlugin();
  static const int dailyNotificationId = 0;
  static const String channelId = 'daily_apod_notif';
  static const String channelName = 'Daily notification';
  bool _dailyNotificationScheduled = false;

  NotificationService() {
    initNotifications();
    checkPendingNotifications();
    //checkGeneralNotificationPermission();
    if (Platform.isIOS) checkIosNotificationPermissions();
    if (Platform.isAndroid) checkAndroidNotificationPermissions();
  }

  get dailyNotificationScheduled => _dailyNotificationScheduled;

  Future<void> initNotifications() async {
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

  Future<void> checkGeneralNotificationPermission() async {
    var permissionStatus = await Permission.notification.status;
    if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
      await Permission.notification.request().then((value) {
        if (value.isDenied || value.isPermanentlyDenied) {
          _dailyNotificationScheduled = false;
        }
      });
    }
    notifyListeners();
  }

  Future<void> checkIosNotificationPermissions() async {
    final bool? notificationPermissions = await _flutterPlugin
      .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
      );
    if (notificationPermissions == null) {
      _dailyNotificationScheduled = false;
    } else {
      if (!notificationPermissions) {
        _dailyNotificationScheduled = false;
      }
    }
    notifyListeners();
  }

  Future<void> checkAndroidNotificationPermissions() async {
    final AndroidFlutterLocalNotificationsPlugin androidPlugin =
        AndroidFlutterLocalNotificationsPlugin();
    var scheduleExactAlarms =
        await androidPlugin.requestExactAlarmsPermission();
    var showNotifications =
        await androidPlugin.requestNotificationsPermission();
    if (scheduleExactAlarms == null || showNotifications == null) {
      _dailyNotificationScheduled = false;
    } else {
      if (!scheduleExactAlarms || !showNotifications) {
        _dailyNotificationScheduled = false;
      }
    }
    notifyListeners();
  }

  Future<void> checkPendingNotifications() async {
    List<PendingNotificationRequest> pendingNotificationRequests =
        await _flutterPlugin.pendingNotificationRequests();
    if (pendingNotificationRequests.isNotEmpty) {
      for (PendingNotificationRequest pendingNotificationRequest
          in pendingNotificationRequests) {
        if (pendingNotificationRequest.id == dailyNotificationId) {
          _dailyNotificationScheduled = true;
          notifyListeners();
        }
      }
    }
  }

  Future<void> cancelDailyNotification() async {
    await _flutterPlugin.cancelAll();
    _dailyNotificationScheduled = false;
    notifyListeners();
  }

  Future<void> scheduleDailyNotification() async {
    await _flutterPlugin.periodicallyShow(
        dailyNotificationId,
        'Astronomy Picture of the Day',
        'Check out the latest APOD',
        RepeatInterval.daily,
        notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.alarmClock);
    _dailyNotificationScheduled = true;

    notifyListeners();
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        importance: Importance.max,
        priority: Priority.high,
        channelDescription:
            "Daily notification to inform you about the latest APOD",
        icon: '@mipmap/ic_launcher',
      ),
    );
  }

  Future<void> showNotification() async {
    await _flutterPlugin.show(
      dailyNotificationId,
      'Astronomy Picture of the Day',
      'Check out the latest APOD',
      notificationDetails(),
    );
  }
}
