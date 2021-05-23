import 'package:firebase_auth/firebase_auth.dart';
import 'package:upass_mobile_repo/data_models/user.dart' as upass;
import 'package:upass_mobile_repo/util/functions_and_shit.dart';
import 'package:upass_mobile_repo/util/prefs.dart';

final AuthService authService = AuthService.instance;

class AuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final AuthService instance = AuthService._privateConstructor();
  static const mm = '🔑 🔑 🔑 🔑 🔑 🔑 AuthService: 🔷🔷 ';
  User? user;

  AuthService._privateConstructor() {
    pp('$mm ... AuthService._privateConstructor has been initialized : 🌺 🌺 🌺 🌺 🌺 '
        '${DateTime.now().toIso8601String()} 🌺');
  }

  void listenForAuthenticationChanges({required Function(bool) onAuthChanged}) async {
    pp('$mm _listen for User authentication changes ... ');
    auth.authStateChanges().listen((user) {
      if (user == null) {
        pp('$mm  👿 👿 👿 User is currently signed out! or has never been registered 👿 ');
        onAuthChanged(false);
      } else {
        pp('$mm User is signed in! ${user.email}');
        onAuthChanged(true);
      }
    });
  }

  Future<bool> isUserAuthenticated() async {
    var m = auth.currentUser;
    if (m == null) {
      pp('$mm  👿 👿 👿  User has NOT been authenticated yet');
      return false;
    } else {
      var token = await m.getIdToken();
      pp('$mm 🤟🏾 🤟🏾 🤟🏾 🤟🏾 🤟🏾 User has already been authenticated 🤟🏾 token: $token 🤟🏾 ');
      pp('$mm 🤟🏾 🤟🏾 🤟🏾 🤟🏾 🤟🏾 User has already been authenticated 🤟🏾 email: ${m.email} 🤟🏾 ');
      var cachedUser = await Prefs.getUser();
      if (cachedUser == null) {
        _saveUser(uid: m.uid, email: m.email!, token: token);
        pp('$mm ✅  ✅  ✅ User updated, was not here before :  ✅ ${m.email}  ✅ ');
      }
      return true;
    }
  }

  Future<upass.User> createUser({required String email, required String password}) async {
    try {
      var result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      if (result.user != null) {
        var token = await result.user!.getIdToken();
        upass.User mUser = _saveUser(uid: result.user!.uid, email: email, token: token);
        return mUser;
      } else {
        pp('$mm createUserWithEmailAndPassword failed: 👿 Null  user returned');
        throw Exception('Create Firebase user failed. Null  user returned');
      }
    } catch (e) {
      pp('$mm 👿 👿 👿 we have a situation here, Joe!  👿  $e');
      throw Exception('Create Firebase user failed. $e');
    }
  }

  upass.User _saveUser({required String uid, required String email, required String token}) {
    var mUser =
        upass.User(userId: uid, email: email, cellphone: 'TBD', date: DateTime.now().toIso8601String(), token: token);
    Prefs.saveUser(mUser);
    pp('$mm user has been created on Firebase Auth 🥦 and saved on disk:  🎽 ${mUser.toJson()} 🎽 ');
    return mUser;
  }
}
