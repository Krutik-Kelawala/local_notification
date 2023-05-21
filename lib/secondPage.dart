import 'package:flutter/material.dart';
import 'package:local_notification/notificationApi.dart';
import 'package:local_notification/notificationService.dart';
import 'package:local_notification/thirdPage.dart';

class secondPage extends StatefulWidget {
  const secondPage({
    Key? key,
  }) : super(key: key);

  @override
  State<secondPage> createState() => _firstPageState();
}

class _firstPageState extends State<secondPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationApi.init();
    listenNotification();
  }

  void listenNotification() {
    NotificationApi.onNotification.stream.listen((onClickNotification));
  }

  void onClickNotification(String? payLoad) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return thirdPg(payLoad: payLoad);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
