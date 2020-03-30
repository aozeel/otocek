import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:newflutter/handler/filter_handler.dart';
import 'package:newflutter/model/cardb.dart';
import 'package:newflutter/utils/database_helper.dart';


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    new FlutterLocalNotificationsPlugin();

Future<void> myBackgroundMessageHandler(Map<String, dynamic> message) async{
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    //print("arka planda gelen data:" + message["data"].toString());
    List<Cardb> carListFuture =await filterhandler.getData(message["data"]["fbasekey"].toString());
    //print(filterhandler.getData("fbasekey"));
    //print(carListFuture[0].model);
    if(carListFuture.isNotEmpty){
      for(var car in carListFuture){NotificationHandler.insertoCars(car);}
      NotificationHandler.showNotification({"data":{"title":"Yeni araçlar geldi !","body":"${carListFuture.length} yeni araç"}});
    }
/*
  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    NotificationHandler.showNotification(message);
    print("arka planda gelen data"+message['data'].toString());
  }*/

  return Future<void>.value();
}}

class NotificationHandler {
  FirebaseMessaging _fcm = FirebaseMessaging();
  static DatabaseHelper databaseHelper = DatabaseHelper();

  static final NotificationHandler _singleton = NotificationHandler._internal();
  factory NotificationHandler() {
    return _singleton;
  }
  NotificationHandler._internal();

  initializeFCMNotification(BuildContext context) async {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    _fcm.subscribeToTopic("newcars");

    

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        //print("onMessage: $message");
        List<Cardb> carListFuture =await filterhandler.getData(message["data"]["fbasekey"].toString());
        if(carListFuture.isNotEmpty){
        for(var car in carListFuture){NotificationHandler.insertoCars(car);}
        showNotification({"data":{"title":"Yeni araçlar geldi !","body":"${carListFuture.length} yeni araç"}});
    }
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  static void showNotification(Map<String, dynamic> message)async {    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '1234', 'yeni mesaj', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      //uygulama açıkken gelen bildirim
        0, message["data"]["title"], message["data"]["body"], platformChannelSpecifics,
        payload: 'Bildirim tıklanılınca aktarılan değer');

       /* insertoCars(new Cardb("https://arbimg29.mncdn.com/ilanfotograflari/2020/02/14/13711629/7fcda096-56c3-4ddb-b3ab-3bcfafeb285c_image_for_silan_13711629_120x90.jpg",
         92.500, "Sahibinden Sorunsuz araç istiyeyene", "istanbul Sarıyer", "BMW X5 30d", "2005", "sahibinden.png"));*/


}

  Future onSelectNotification(String payload) {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {}

      static void insertoCars(Cardb carList) async{
          await databaseHelper.insertCar(carList);
      }
}
