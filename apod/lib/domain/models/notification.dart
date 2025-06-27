import 'package:logger/web.dart';

class Notification {
  final int notificationId;
  final String channelId;
  final String channelName;
  final String channelDescription;
  final bool isScheduled;
  final String title;
  final String bodyText;

  Notification({
    required this.notificationId,
    required this.channelId,
    required this.channelName,
    required this.channelDescription,
    this.isScheduled = false,
    required this.title,
    required this.bodyText,
  });

  Notification updateScheduled(bool newStatus) {
    Logger().d('Updating notification scheduled status: $newStatus');
    return Notification(
      notificationId: notificationId,
      channelId: channelId,
      channelName: channelName,
      channelDescription: channelDescription,
      isScheduled: newStatus,
      title: title,
      bodyText: bodyText,
    );
  }
}
