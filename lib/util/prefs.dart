import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:upass_mobile_repo/data_models/user.dart';

import 'functions_and_shit.dart';

class Prefs {
  static void setThemeIndex(int index) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt('index', index);
    print('🔵 🔵 🔵 Prefs: theme index set to: $index 🍎 🍎 ');
  }

  static Future<int> getThemeIndex() async {
    final preferences = await SharedPreferences.getInstance();
    var b = preferences.getInt('index');
    if (b == null) {
      return 0;
    } else {
      print('🔵 🔵 🔵  theme index retrieved: $b 🍏 🍏 ');
      return b;
    }
  }

  static Future saveUser(User user) async {
    final preferences = await SharedPreferences.getInstance();
    var mJson = jsonEncode(user.toJson());
    await preferences.setString('user', mJson);
    pp('Prefs:  🔵 🔵 🔵 user saved: ${user.toJson()} 🍎 🍎 ');
    return null;
  }

  static Future<User?> getUser() async {
    final preferences = await SharedPreferences.getInstance();
    var b = preferences.getString('user');
    if (b == null) {
      return null;
    } else {
      var user = User.fromJson(jsonDecode(b));
      pp('Prefs: 🔵 🔵 🔵 user retrieved: ${user.toJson()} 🍏 🍏 ');
      return user;
    }
  }
}
