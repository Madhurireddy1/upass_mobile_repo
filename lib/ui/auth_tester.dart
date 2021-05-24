import 'package:flutter/material.dart';
import 'package:upass_mobile_repo/data_models/user.dart';
import 'package:upass_mobile_repo/services/auth_firebase.dart';
import 'package:upass_mobile_repo/util/functions.dart';
import 'package:upass_mobile_repo/util/functions_and_shit.dart';
import 'package:upass_mobile_repo/util/snack.dart';

class UpassAuth extends StatefulWidget {
  const UpassAuth({Key? key}) : super(key: key);

  @override
  _UpassAuthState createState() => _UpassAuthState();
}

class _UpassAuthState extends State<UpassAuth> {
  User? user;
  String type = 'NotKnownYet';
  static const mm = 'UpassAuth: 💙 💙 💙 💙 💙 : ';
  var _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('UPass Authentication'),
      ),
      backgroundColor: Colors.brown[100],
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                width: 300,
                height: 300,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(width: 160, child: ElevatedButton(onPressed: _emailSignIn, child: Text('Email'))),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(width: 160, child: ElevatedButton(onPressed: _phoneSignIn, child: Text('Phone'))),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(width: 160, child: ElevatedButton(onPressed: _googleSignIn, child: Text('Google'))),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(width: 160, child: ElevatedButton(onPressed: _facebookSignIn, child: Text('Facebook'))),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(width: 160, child: ElevatedButton(onPressed: _twitterSignIn, child: Text('Twitter'))),
                    ],
                  ),
                ),
              ),
              user == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 120,
                        width: 300,
                        child: Card(
                          color: Colors.teal[100],
                          elevation: 8,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 24,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      '$type - User Signed In',
                                      style: Styles.tealBoldSmall,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 28.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.person),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text('${user!.email!}')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  void _facebookSignIn() async {
    pp('$mm Signing on with Facebook ....');
    try {
      user = await authService.signInFacebook();
      pp('🔴 🔴 Successfully authenticated with 🧡 FACEBOOK : ${user!.email!}');
      setState(() {
        type = 'Facebook';
      });
    } catch (e) {
      AppSnackBar.showErrorSnackBar(scaffoldKey: _key, message: 'Failed: $e');
    }
  }

  void _googleSignIn() async {
    pp('$mm Signing on with Google ....');
    try {
      user = await authService.signInWithGoogle();
      pp('🔴 🔴 Successfully authenticated with 🧡 GOOGLE : ${user!.email!}');
      setState(() {
        type = 'Google';
      });
    } catch (e) {
      AppSnackBar.showErrorSnackBar(scaffoldKey: _key, message: 'Failed: $e');
    }
  }

  void _twitterSignIn() async {
    pp('$mm Signing on with Twitter ....');
    try {
      user = await authService.signInTwitter();
      pp('🔴 🔴 Successfully authenticated with 🧡 TWITTER : ${user!.email!}');
      setState(() {
        type = 'Twitter';
      });
    } catch (e) {
      AppSnackBar.showErrorSnackBar(scaffoldKey: _key, color: Colors.pink[900], message: 'Failed: $e');
    }
  }

  void _emailSignIn() async {
    pp('$mm Signing on with Email ....');
    // user = await authService.signInWithEmail(email: 'aubrey@aftarobot.com', password: 'matimba23#');
    try {
      user = await authService.signInWithEmail(email: 'republican@aftarobot.com', password: 'matimba23#');

      pp('🔴 🔴 Successfully authenticated with 🧡 EMAIL : ${user!.email!}');
      setState(() {
        type = 'Email';
      });
    } catch (e) {
      AppSnackBar.showErrorSnackBar(scaffoldKey: _key, message: 'Failed: $e');
    }
  }

  void _phoneSignIn() async {
    pp('$mm Signing on with Phone ....');
    try {
      user = await authService.signInWithPhone();
      pp('🔴 🔴 Successfully authenticated with 🧡 PHONE : ${user!.email!}');
      setState(() {
        type = 'Phone';
      });
    } catch (e) {
      AppSnackBar.showErrorSnackBar(scaffoldKey: _key, message: 'Failed: $e');
    }
  }
}
