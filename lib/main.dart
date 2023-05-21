import 'package:flutter/material.dart';
import 'package:local_notification/notificationService.dart';
import 'package:local_notification/secondPage.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:workmanager/workmanager.dart';

void main() {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  Workmanager().initialize(

      // The top level function, aka callbackDispatcher
      callbackDispatcher,

      // If enabled it will post a notification whenever
      // the task is running. Handy for debugging tasks
      isInDebugMode: true);
  // Periodic task registration
  Workmanager().registerPeriodicTask(
      "simplePeriodicTask",

      //This is the value that will be
      // returned in the callbackDispatcher
      "simplePeriodicTask",

      // When no frequency is provided
      // the default 15 minutes is set.
      // Minimum frequency is 15 min.
      // Android will automatically change
      // your frequency to 15 min
      // if you have configured a lower frequency.
      frequency: const Duration(minutes: 15),
      existingWorkPolicy: ExistingWorkPolicy.keep,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ));
  runApp(const MaterialApp(
    home: firstPage(),
  ));
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  try {
    Workmanager().executeTask((task, inputData) async {
      // initialise the plugin of flutterlocalnotifications.

      // app_icon needs to be a added as a drawable
      // resource to the Android head project.
      NotificationService.androidInitializationSettings;

      print("notification Initialize");

      // initialise settings for both Android and iOS device.
      NotificationService.intializeNotification();


      print("Zone schedule notification called");

      NotificationService.scheduleNotification("title", 'bodyMsg', 'payLoad');
      /*NotificationService.zoneScheduleNotification(
          NotificationService.id++, "title", 'bodyMsg', 'payLoad');*/

      return Future.value(true);
    });
  } on Exception catch (e) {
    // TODO
    print(e);
  }
}

class firstPage extends StatefulWidget {
  const firstPage({Key? key}) : super(key: key);

  @override
  State<firstPage> createState() => _firstPageState();
}

class _firstPageState extends State<firstPage> {
  // NotificationService notificationService = NotificationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationService.intializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("First Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  NotificationService.sendNotification(
                      "This is Title", "This is massage", "its_payload");
                  /*notificationService.sendNotification(
                      "This is Title", "This is massage");*/
                },
                child: const Text("Send Notification")),
            ElevatedButton(
                onPressed: () {
                  NotificationService.scheduleNotification(
                      "Schedule Notification",
                      "This is schedule Notification",
                      "its_payload");
                  /* notificationService.scheduleNotification(
                      "Schedule Notification", "This is schedule Notification");*/
                },
                child: const Text("Schedule Notification")),
            ElevatedButton(
                onPressed: () {
                  // notificationService.stopNotification();
                  NotificationService.zoneScheduleNotification(
                      0,
                      "Zone schedule Notification",
                      "this Is body msg",
                      "payload.abc");
                },
                child: const Text("Zone Schedule Notification")),
            ElevatedButton(
                onPressed: () {
                  // notificationService.stopNotification();
                  NotificationService.stopNotification();
                },
                child: const Text("Stop Notification")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const secondPage();
                    },
                  ));
                },
                child: const Text("Second Page")),
          ],
        ),
      ),
    );
  }
}
