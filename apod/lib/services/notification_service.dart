import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidFlutterLocalNotificationsPlugin
      _androidFlutterLocalNotificationsPlugin =
      AndroidFlutterLocalNotificationsPlugin();
  static const int dailyNotificationId = 25;
  static const String channelId = 'daily_apod_notif';
  static const String channelName = 'Daily notification';
  bool _dailyNotificationScheduled = false;

  NotificationService() {
    initNotifications();
    checkPendingNotifications();
    checkNotificationPermissions();
  }

  get dailyNotificationScheduled => _dailyNotificationScheduled;

  Future<void> initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> checkNotificationPermissions() async {
    var scheduleExactAlarms = await _androidFlutterLocalNotificationsPlugin
        .requestExactAlarmsPermission();
    var showNotifications = await _androidFlutterLocalNotificationsPlugin
        .requestNotificationsPermission();
    var permissionStatus = await Permission.notification.status;
    if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
      await Permission.notification.request().then((value) {
        if (value.isDenied || value.isPermanentlyDenied) {
          _dailyNotificationScheduled = false;
        }
      });
    }
    if (scheduleExactAlarms == null || showNotifications == null) {
      _dailyNotificationScheduled = false;
    } else {
      if (!scheduleExactAlarms || !showNotifications) {
        _dailyNotificationScheduled = false;
      }
    }
    notifyListeners();
  }

  checkPendingNotifications() async {
    List<PendingNotificationRequest> pendingNotificationRequests =
        await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
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
    await _flutterLocalNotificationsPlugin.cancelAll();
    _dailyNotificationScheduled = false;
    notifyListeners(); 
  }

  Future<void> scheduleDailyNotification() async {
    await _flutterLocalNotificationsPlugin.periodicallyShow(
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

  // Future<void> showNotification() async {
  //   await _flutterLocalNotificationsPlugin.show(
  //     id,
  //     'Astronomy Picture of the Day',
  //     'Check out the latest APOD',
  //     notificationDetails(),
  //   );
  // }
}
