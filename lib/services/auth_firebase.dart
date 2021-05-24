import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:upass_mobile_repo/data_models/user.dart' as upass;
import 'package:upass_mobile_repo/util/functions_and_shit.dart';
import 'package:upass_mobile_repo/util/prefs.dart';

final AuthService authService = AuthService.instance;

class AuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final AuthService instance = AuthService._privateConstructor();
  static const mm = '🔑 🔑 🔑 🔑 🔑 🔑 AuthService: 🔷🔷 ';
  User? user;
  var faceBook = FacebookAuth.instance;
  AuthService._privateConstructor() {
    pp('$mm ... AuthService._privateConstructor has been initialized : 🌺 🌺 🌺 🌺 🌺 '
        '${DateTime.now().toIso8601String()} 🌺');
  }

  Future initialize() async {}

  Future<upass.User?> signInWithEmail({required String email, required String password}) async {
    pp('$mm Sign in with Email .... $email $password');
    try {
      var userCred = await auth.signInWithEmailAndPassword(email: email, password: password);
      if (userCred.user == null) {
        var mUser = createUser(email: email, password: password);
        return mUser;
      } else {
        var token = await auth.currentUser!.getIdToken();
        var mUser = _saveUser(uid: userCred.user!.uid, email: email, token: token);
        return mUser;
      }
    } catch (e) {
      if (e.toString().contains('user-not-found')) {
        var mUser = createUser(email: email, password: password);
        return mUser;
      } else {
        pp('$mm 👿👿👿  We are fucked! 👿👿👿  $e');
        throw Exception('Failed : $e');
      }
    }
    return null;
  }

  Future<upass.User> signInFacebook() async {
    pp('$mm Sign in with Facebook ....');

    final LoginResult result = await faceBook.login();
    pp('$mm Facebook loginResult: ${result.status.toString()} ${result.accessToken} '
        '${result.message}');

    // Create a credential from the access token
    final facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);
    // Once signed in, return the UserCredential
    var cred = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    var token = await getIdToken();
    var user = await _saveUser(uid: cred.user!.uid, email: cred.user!.email!, token: token!);
    pp('$mm Facebook user : ${user.toJson()}');
    return user;
  }

  Future<upass.User?> signInTwitter() async {
    pp('$mm Sign in with Twitter ....');

    return null;
  }

  Future<upass.User?> signInWithPhone() async {
    pp('$mm Sign in with Phone ....');
    return null;
  }

  Future<upass.User?> signInWithTwitter() async {
    pp('$mm Sign in with Twitter ....');
    return null;
  }

  Future<upass.User?> signInWithGoogle() async {
    pp('$mm Sign in with Google ....');
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    var cred = await FirebaseAuth.instance.signInWithCredential(credential);
    var idToken = await cred.user!.getIdToken();
    pp('$mm User credential from Google SignIn: ${cred.user!.email} - $idToken');
    var user = _saveUser(uid: cred.user!.uid, email: cred.user!.email!, token: idToken);
    return user;
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

  Future<String?> getIdToken() async {
    var m = auth.currentUser;
    if (m == null) {
      pp('$mm 👿 👿 👿 User has NOT been authenticated yet');
      return null;
    } else {
      var token = await m.getIdToken();
      return token;
    }
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
        upass.User mUser = await _saveUser(uid: result.user!.uid, email: email, token: token);
        pp('$mm ✅  ✅  ✅ Signing in with new user credentials ....');
        auth.signInWithEmailAndPassword(email: email, password: password);
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

  Future<upass.User> _saveUser({required String uid, required String email, required String token}) async {
    var mUser =
        upass.User(userId: uid, email: email, cellphone: 'TBD', date: DateTime.now().toIso8601String(), token: token);
    await Prefs.saveUser(mUser);
    pp('$mm user has been created on Firebase Auth 🥦 and saved on disk:  🎽 ${mUser.toJson()} 🎽 ');
    return mUser;
  }
}
