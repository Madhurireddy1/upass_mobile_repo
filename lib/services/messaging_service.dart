import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:upass_mobile_repo/data_models/geofence_location.dart';
import 'package:upass_mobile_repo/data_models/user.dart';
import 'package:upass_mobile_repo/util/functions_and_shit.dart';
import 'package:upass_mobile_repo/util/prefs.dart';

final MessagingService messagingService = MessagingService.instance;

class MessagingService {
  static const mm = '🔊 🔊 🔊 🔊 🔊 🔊  🔴 MessagingService 🔴 : ';
  static final MessagingService instance = MessagingService._privateConstructor();
  static const generalTopic = 'generalTopic';
  User? user;

  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  MessagingService._privateConstructor() {
    pp('$mm ... MessagingService._privateConstructor has been built : 🛅 🛅 🛅 '
        '${DateTime.now().toIso8601String()} 🛅 ');
  }

  Future? getToken() async {
    var tok = await _messaging.getToken();
    pp('$mm getToken returns: 🛅 $tok 🛅 ');
    return tok;
  }

  Future? initialize() async {
    pp('$mm ... Initializing ....');
    _messaging.setAutoInitEnabled(true);
    user = await Prefs.getUser();
    if (user != null) {
      pp('$mm ... User retrieved from sharedPrefs:  ${user!.email} ... ');
    } else {
      pp('$mm ... 👿👿👿👿👿 User not set up yet! 👿👿👿👿👿');
    }
    await _messaging.subscribeToTopic(generalTopic);
    pp('$mm ... Subscribed to the famous General topic ... ');
    // await _messaging.requestNotificationPermissions(
    //   IosNotificationSettings(
    //     alert: true,
    //     badge: true,
    //     provisional: false,
    //     sound: true,
    //   ),
    // );
    return true;
  }



}
