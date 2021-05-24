import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:upass_mobile_repo/data_models/user.dart';
import 'package:upass_mobile_repo/services/auth_firebase.dart';
import 'package:upass_mobile_repo/util/functions_and_shit.dart';
import 'package:upass_mobile_repo/util/util.dart';

final NetworkService networkService = NetworkService.instance;

class NetworkService {
  static final NetworkService instance = NetworkService._privateConstructor();
  static const mm = '💜 💜 💜 💜 💜 NetworkService: 🔷🔷 ';
  User? user;

  NetworkService._privateConstructor() {
    pp('$mm ... NetworkService._privateConstructor has been initialized : 🌺 🌺 🌺 🌺 🌺 '
        '${DateTime.now().toIso8601String()} 🌺');
  }

  static final client = http.Client();
  static const Map<String, String> xHeaders = {
    'Content-type': 'application/json',
    'Accept': '*/*',
  };

  static const timeOutInSeconds = 30;

  Future post({required String apiRoute, required Map bag}) async {
    var url = await getBaseUrl();
    var token = await authService.getIdToken();
    if (token == null) {
      throw Exception('authentication token not available');
    }
    var mHeaders = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    var dur = Duration(seconds: timeOutInSeconds);
    apiRoute = url + apiRoute;
    pp('$mm: POST:  ................................... 🔵 '
        '🔆 calling backend: 💙 $apiRoute 💙');
    var mBag;
    if (bag != null) {
      mBag = jsonEncode(bag);
    }
    if (mBag == null) {
      p('$mm 👿 Bad moon rising? 👿 bag is null, may not be a problem ');
    }
    p(mBag);
    var start = DateTime.now();
    try {
      var uriResponse = await client.post(Uri.parse(apiRoute), body: mBag, headers: mHeaders);
      var end = DateTime.now();
      p('$mm RESPONSE: 💙 status: ${uriResponse.statusCode} 💙 body: ${uriResponse.body}');

      if (uriResponse.statusCode == 200) {
        p('$mm 💙 statusCode: 👌👌👌 ${uriResponse.statusCode} 👌👌👌 💙 '
            'for $apiRoute 🔆 elapsed: ${end.difference(start).inSeconds} seconds 🔆');
        try {
          var mJson = json.decode(uriResponse.body);
          return mJson;
        } catch (e) {
          return uriResponse.body;
        }
      } else {
        p('$mm 👿👿👿👿👿👿👿👿👿 Bad moon rising ...POST failed! 👿👿  fucking status code: '
            '👿👿 ${uriResponse.statusCode} 👿👿');
        throw Exception('🚨 🚨 Status Code 🚨 ${uriResponse.statusCode} 🚨 body: ${uriResponse.body}');
      }
    } finally {
      // client.close();
    }
  }

  Future get({required String apiRoute}) async {
    var url = await getBaseUrl();
    var token = await authService.getIdToken();
    if (token == null) {
      throw Exception('authentication token not available');
    }
    var mHeaders = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    apiRoute = url + apiRoute;
    p('$mm GET:  🔵 '
        '🔆 .................. calling backend: 💙 $apiRoute  💙');
    var start = DateTime.now();
    // var dur = Duration(seconds: mTimeOut == null ? timeOutInSeconds : mTimeOut);
    try {
      var uriResponse = await client.get(Uri.parse(apiRoute), headers: mHeaders);
      var end = DateTime.now();
      p('$mm RESPONSE: 💙 status: ${uriResponse.statusCode} 💙 body: ${uriResponse.body}');

      if (uriResponse.statusCode == 200) {
        p('$mm 💙 statusCode: 👌👌👌 ${uriResponse.statusCode} 👌👌👌 💙 '
            'for $apiRoute 🔆 elapsed: ${end.difference(start).inSeconds} seconds 🔆');
        try {
          var mJson = json.decode(uriResponse.body);
          return mJson;
        } catch (e) {
          return uriResponse.body;
        }
      } else {
        p('$mm 👿👿👿👿👿👿👿 Bad moon rising ....GET failed! 👿👿 fucking status code: '
            '👿👿 ${uriResponse.statusCode} 👿👿');
        throw Exception('🚨 🚨 Status Code 🚨 ${uriResponse.statusCode} 🚨 body: ${uriResponse.body}');
      }
    } finally {
      // client.close();
    }
  }

  Future getWithNoAuth({required String apiRoute, required int mTimeOut}) async {
    var url = await getBaseUrl();
    var mHeaders = {'Content-Type': 'application/json'};
    apiRoute = '$url$apiRoute';
    p('$mm getWithNoAuth:  🔆 calling backend:  ............apiRoute: 💙 '
        '$apiRoute  💙');
    var start = DateTime.now();
    try {
      var uriResponse = await client.get(Uri.parse(apiRoute), headers: mHeaders);
      var end = DateTime.now();
      p('$mm RESPONSE: 💙 status: ${uriResponse.statusCode} 💙 body: ${uriResponse.body}');
      if (uriResponse.statusCode == 200) {
        p('$mm 💙 statusCode: 👌👌👌 ${uriResponse.statusCode} 👌👌👌 💙 '
            'for $apiRoute 🔆 elapsed: ${end.difference(start).inSeconds} seconds 🔆');
        try {
          var mJson = json.decode(uriResponse.body);
          return mJson;
        } catch (e) {
          return uriResponse.body;
        }
      } else {
        p('$mm 👿👿👿👿👿👿👿👿👿 Bad moon rising ....  fucking status code: '
            '👿👿 ${uriResponse.statusCode} 👿👿');
        throw Exception('🚨 🚨 Status Code 🚨 ${uriResponse.statusCode} 🚨 body: ${uriResponse.body}');
      }
    } finally {
      client.close();
    }
  }
}
