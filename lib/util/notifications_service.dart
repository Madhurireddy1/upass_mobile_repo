import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:upass_mobile_repo/data_models/user.dart';
import 'package:upass_mobile_repo/ui/notif_receiver.dart';
import 'package:upass_mobile_repo/util/prefs.dart';

import 'functions_and_shit.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();
final BehaviorSubject<String?> selectNotificationSubject = BehaviorSubject<String?>();
const MethodChannel platform = MethodChannel('boha.dev/flutter_local_notifications_example');

/// Define a top-level named handler which background/terminated messages will
/// call.
/// To verify things are working, check out the native platform logs.
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  pp('🔴  🔴  🔴  🔴  🔴  Handling a background message  🔴 ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true,
    enableVibration: true);

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

late NotificationService notificationService;

class NotificationService {
  late BuildContext context;

  NotificationService(BuildContext context) {
    this.context = context;
    pp('$mm NotificationService construction: 🍊 🍊 context passed in: ${context.toString()}');
    _startConfiguring();
    subscribeToTopics();
  }

  void requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future _startConfiguring() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    pp('$mm _startConfiguring: 🍊 🍊 notificationAppLaunchDetails.didNotificationLaunchApp : ${notificationAppLaunchDetails!.didNotificationLaunchApp} 🍊 🍊 ');
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later

    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) => _onShitHappening(id, title!, body!, payload!),
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    pp('$mm _startConfiguring: 🍊 🍊 initializationSettings.defaultIcon : ${initializationSettings.android!.defaultIcon} 🍊 🍊 ');
    pp('$mm _startConfiguring: 🍊 🍊 initializationSettings.defaultPresentAlert : ${initializationSettings.iOS!.defaultPresentAlert} 🍊 🍊 ');

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        pp('$mm notification payload: $payload');
      }
      selectedNotificationPayload = payload;
      selectNotificationSubject.add(payload);
    });

    pp('$mm _startConfiguring: 🍊 🍊 FlutterLocalNotificationsPlugin initialized 🍊 🍊 ');
    _configureLocalTimeZone();
    _configureDidReceiveLocalNotificationSubject();
    _listenUp();
  }

  Future _listenUp() async {
    pp('$mm _listenUp : 💙 set up FirebaseMessaging.onMessage listener ..... 💙 💙 💙');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      pp('$mm _listenUp : 💙 onMessage listener FIRED: message: ${message.senderId} - ${message.data}.....');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        pp('$mm _listenUp : handle Android notification here 💙 ');
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    pp('$mm _listenUp : 💙  listening to onMessageOpenedApp .....');
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      pp('$mm A new onMessageOpenedApp event was published! 💙 ${message.data} 💙');
    });
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    pp('$mm _configureLocalTimeZone: timeZoneName: 🌍 🌍 🌍 🌍  $timeZoneName 🌍 🌍 🌍 🌍');
  }

  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static const generalTopic = 'generalTopic';
  User? user;

  Future subscribeToTopics() async {
    pp('\n$mm ... Subscribing to the famous General topic + a personal one ... ');
    await _messaging.subscribeToTopic(generalTopic);
    pp('$mm ... Subscribed to the famous General topic ... ');
    await _subscribeToPersonalTopic();
  }

  Future<void> _subscribeToPersonalTopic() async {
    var user = await Prefs.getUser();
    if (user != null) {
      var topic = 'personal_${user.userId}';
      await _messaging.subscribeToTopic(topic);
      pp('$mm ... Subscribed to a personal topic ... 🔷 $topic 🔷\n');
    } else {
      pp('$mm ... Subscribing to a personal topic failed, user is NULL\n');
    }
  }

  void _configureDidReceiveLocalNotificationSubject() {
    pp('$mm _configureDidReceiveLocalNotificationSubject starting .....  🍊 🍊 🍊 🍊 ');
    didReceiveLocalNotificationSubject.stream.listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: this.context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null ? Text(receivedNotification.title!) : null,
          content: receivedNotification.body != null ? Text(receivedNotification.body!) : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => NotifReceiver(
                      payload: receivedNotification.payload!,
                    ),
                  ),
                );
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void addTopic({required User user}) async {}

  void configureSelectNotificationSubject(BuildContext context) {
    selectNotificationSubject.stream.listen((String? payload) async {
      await Navigator.pushNamed(context, '/secondPage');
    });
  }

  Future<String> onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
    pp('$mm onDidReceiveLocalNotification:🍏 title: $title 🍏 payload: $payload 🍏 body: $body ');
    return payload;
  }

  Future selectNotification(String payload) async {
    pp('$mm selectNotification: 🍏 payload: $payload');
    return null;
  }

  static const mm = '🔊 🔊 🔊 🔊 🔊 🔊 🔷 NotificationService: 🔷 ';

  Future _onShitHappening(int id, String title, String body, String payload) {
    pp('$mm _onShitHappening: title: $title body: $body payload: $payload ...');
    dynamic cc = "hey";
    return cc;
  }
}
