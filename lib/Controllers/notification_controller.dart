import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../util/apiClient.dart';

class NotificationController extends GetxController {
  late ApiClient apiClient;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // NotificationController({this.apiClient});
  Future<void> getNoticationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print(AuthorizationStatus.authorized);
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print(AuthorizationStatus.provisional);
    } else {
      print(AuthorizationStatus.denied);
    }
  }

  Future<void> initInfo() async {
    var androidInitializer =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    //var iosInitilalize = IOSIntializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitializer);
    flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse: (NotificationResponse? payLoad) async {
        try {
          if (payLoad != null && payLoad.payload!.isEmpty) {
          } else {}
        } catch (e) {
          print(e.toString());
        }
      },
      //  onDidReceiveBackgroundNotificationResponse:
      //         (NotificationResponse? payLoad) async {
      //   try {
      //     if (payLoad != null && payLoad.payload!.isEmpty) {
      //     } else {}
      //   } catch (e) {}
      // }
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: message.notification!.title,
          htmlFormatContentTitle: true);
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('shop4you', 'shop4you',
              importance: Importance.high,
              styleInformation: bigTextStyleInformation,
              playSound: true,
              priority: Priority.high);

      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
      );
      await flutterLocalNotificationsPlugin.show(0, message.notification!.title,
          message.notification!.body, notificationDetails,
          payload: message.data['body']);
    });
  }

  Future<void> sendNotification(
      {String? title, String? nbody, String? token}) async {
    apiClient = ApiClient(appBaseUrl: 'https://fcm.googleapis.com/');
    FirebaseFirestore fStore = FirebaseFirestore.instance;
    try {
      var sevKey = await fStore.collection('admin').doc('servKey').get();
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'key=${sevKey["key"]}'
      };
      Map<String, dynamic> body = {
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'status': 'done',
          'body': nbody,
          'title': title,
        },
        'notification': <String, dynamic>{
          'title': title,
          'body': nbody,
          'android_channel_id': 'shop4you'
        },
        'to': token
      };
      String encodedBody = jsonEncode(body);
      await apiClient.postData(
          uri: 'fcm/send', body: encodedBody, headers: headers);
    } catch (e) {
      if (kDebugMode) {
        print('error push notification : $e');
      }
    }
  }

  // Future<void> sendNotification2(
  //     {String? title, String? nbody, String? token}) async {
  //   FirebaseFirestore fStore = FirebaseFirestore.instance;
  //   try {
  //     var sevKey = await fStore.collection('admin').doc('servKey').get();
  //     print("This is the server key: ${sevKey["key"]}");
  //     Map<String, String> headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'key=${sevKey["key"]}'
  //     };
  //     Map<String, dynamic> body = {
  //       'priority': 'high',
  //       'data': <String, dynamic>{
  //         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //         'status': 'done',
  //         'body': nbody,
  //         'title': title,
  //       },
  //       'notification': <String, dynamic>{
  //         'title': title,
  //         'body': nbody,
  //         'android_channel_id': 'shop4you'
  //       },
  //       'to': token
  //     };
  //     String encodedBody = jsonEncode(body);
  //     await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send/'),
  //         headers: headers, body: encodedBody);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('error push notification : $e');
  //     }
  //   }
  // }
}
