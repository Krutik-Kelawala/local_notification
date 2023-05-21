import 'package:flutter/material.dart';
import 'package:local_notification/notificationApi.dart';

class thirdPg extends StatefulWidget {
  thirdPg({Key? key, String? payLoad}) : super(key: key);

  @override
  State<thirdPg> createState() => _thirdPgState();
}

class _thirdPgState extends State<thirdPg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(""),
            ElevatedButton(
                onPressed: () {
                  NotificationApi.showNotiFicationApi(
                    title: 'second pg this notification',
                    body: "this is body msg",
                    payLoad: 'eep.com',
                  );
                },
                child: Text("Secondpg Send Notification")),
            ElevatedButton(
                onPressed: () {},
                child: Text("Secondpg Schedule Notification")),
            ElevatedButton(onPressed: () {}, child: Text("Stop Notification")),
          ],
        ),
      ),
    );
  }
}
