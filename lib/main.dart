import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geofence_service/geofence_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upass_mobile_repo/on_boarding/on_boarding_main.dart';
import 'package:upass_mobile_repo/services/hive_db.dart';
import 'package:upass_mobile_repo/util/notifications_service.dart';

import 'util/functions_and_shit.dart';

const mm = '🖐🏽🖐🏽🖐🏽🖐🏽🖐🏽🖐🏽 💪 💙 UPASS Mobile App: 💙 💪';

void main() async {
  pp('$mm Stanley Black & Decker starting up .... ');
  WidgetsFlutterBinding.ensureInitialized();
  pp('$mm Firebase.initializeApp starting ............');
  await Firebase.initializeApp();
  pp('$mm Firebase.initializeApp executed 🍎 🍎 OK 🍎 🍎 ');
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MyApp());
  });

  await localDB.initializeHive();
  pp('$mm Stanley Black & Decker UPASS Mobile App started 🍎 🍎 OK 🍎 🍎 ');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.montserratAlternatesTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      // A widget used when you want to start a foreground task when trying to minimize or close the app.
      // Declare on top of the [Scaffold] widget.
      home: WillStartForegroundTask(
          onWillStart: () {
            // You can add a foreground task start condition.
            //pp('$mm App main: 🍊 🍊 WillStartForegroundTask 🔵 onWillStart 🍊 🍊 \n WHAT the fuck DOES THIS code DO???');
            return true;
          },
          notificationOptions: NotificationOptions(
              channelId: 'geofence_service_notification_channel',
              channelName: 'Geofence Builder Notification',
              channelDescription:
                  'This notification appears when the Geofence Builder service is running in the background.',
              channelImportance: NotificationChannelImportance.LOW,
              priority: NotificationPriority.LOW),
          notificationTitle: '💪 💪 💪 Geofence Builder is RUNNING! 💪',
          notificationText: 'Tap here to navigate to UPASS, thank you very much!',
          taskCallback: _taskCallback,
          child: OnBoardingMain()),
    );
  }

  void _taskCallback(DateTime timestamp) {
    pp('$mm _taskCallback: 🍊 🍊 timestamp: ${timestamp.toIso8601String()} 🍊 🍊  what do we do now, Senor?');
  }
}
