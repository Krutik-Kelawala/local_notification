import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static int id = 0;

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static AndroidInitializationSettings androidInitializationSettings =
      const AndroidInitializationSettings('notification_ic');

  static void intializeNotification() async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // TODO ontap to send notification
  static void sendNotification(
      String title, String bodyMsg, String payLoad) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max, priority: Priority.high);

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        NotificationService.id++, title, bodyMsg, notificationDetails,
        payload: payLoad);
  }

  // TODO set schedule for notification
  static void scheduleNotification(
      String title, String bodyMsg, String payLoad) async {

    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'channelName',
      channelDescription: 'channel Description Here',
      importance: Importance.max,
      priority: Priority.high,
      enableLights: true,
      enableVibration: true,
      channelShowBadge: true,
      playSound: true,
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.periodicallyShow(
        NotificationService.id++,
        title,
        bodyMsg,
        RepeatInterval.everyMinute,
        notificationDetails,
        payload: payLoad);
  }

  // TODO set zone schedule for notification
  static void zoneScheduleNotification(
      int id, String title, String bodyMsg, String payLoad) async {

    print("Zone schedule notification method called");

    tz.initializeTimeZones();

    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'channelName',
      channelDescription: 'channel Description Here',
      importance: Importance.max,
      priority: Priority.high,
      enableLights: true,
      enableVibration: true,
      channelShowBadge: true,
      playSound: true,
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      payload: payLoad,
      title,
      bodyMsg,
      convertTime(14),
      /* tz.TZDateTime.now(tz.local)
          .add(const Duration(days: 0, minutes: 2, seconds: 0)),*/
      notificationDetails,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  static tz.TZDateTime convertTime(int hour) {

    tz.initializeTimeZones();

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, 25);
    print("schedule Date $scheduleDate");

    return scheduleDate;
  }

  // TODO stop all notification
  static void stopNotification() {
    flutterLocalNotificationsPlugin.cancelAll();
  }
}
