import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geofence_service/geofence_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upass_mobile_repo/on_boarding/on_boarding_main.dart';
import 'package:upass_mobile_repo/services/hive_db.dart';
import 'package:upass_mobile_repo/util/notifications_service.dart';

import 'util/functions_and_shit.dart';

const mm = '🖐🏽🖐🏽🖐🏽🖐🏽🖐🏽🖐🏽 💙 UPASS Mobile App: 💙 ';

void main() async {
  pp('$mm Stanley Black & Decker starting up .... ');
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
    // runApp(
    //   DevicePreview(
    //     enabled: kIsWeb ? false : !kReleaseMode,
    //     builder: (_) => MyApp(),
    //   ),
    // );
  });

  await localDB.initializeHive();
  pp('$mm Firebase.initializeApp starting ............');
  await Firebase.initializeApp();
  pp('$mm Firebase.initializeApp executed 🍎 🍎 OK 🍎 🍎 ');
  pp('$mm Stanley Black & Decker UPASS Mobile App started 🍎 🍎 OK 🍎 🍎 ');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    notificationService = NotificationService(context);
    pp('$mm NotificationService constructed ... 🍎 and hopefully initialized 🍎 $mm');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
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
            pp('$mm App main: 🍊 🍊 WillStartForegroundTask 🔵 onWillStart 🍊 🍊 \n WHAT the fuck DOES THIS code DO???');
            return true;
          },
          notificationOptions: NotificationOptions(
              channelId: 'geofence_service_notification_channel',
              channelName: 'Geofence Builder Notification',
              channelDescription:
                  'This notification appears when the Geofence Builder service is running in the background.',
              channelImportance: NotificationChannelImportance.LOW,
              priority: NotificationPriority.LOW),
          notificationTitle: 'Geofence Builder is RUNNING!',
          notificationText: 'Tap here to navigate to the app',
          taskCallback: _taskCallback,
          child: OnBoardingMain()),
    );
  }

  void _taskCallback(DateTime timestamp) {
    pp('$mm _taskCallback: 🍊 🍊 timestamp: ${timestamp.toIso8601String()} 🍊 🍊  what do we do now, Senor?');
  }
}
