import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static FlutterLocalNotificationsPlugin notificationApi =
      FlutterLocalNotificationsPlugin();

  static final onNotification = BehaviorSubject<String?>();

  static Future NotificationDetailsApi() async {
    return NotificationDetails(
        android: AndroidNotificationDetails('channel Id', 'channel Name',
            importance: Importance.max, priority: Priority.high,));
  }

  static Future init({bool iniSchedule = false}) async {
    AndroidInitializationSettings androidInitializationSettingsApi =
        AndroidInitializationSettings('notification_ic');
    final setting =
        InitializationSettings(android: androidInitializationSettingsApi);
    await notificationApi.initialize(
      setting,
    );
  }

  static Future showNotiFicationApi({
    int id = 0,
    String? title,
    String? body,
    String? payLoad,
  }) async =>
      notificationApi.show(id, title, body, await NotificationDetailsApi(),
          payload: payLoad);
}
