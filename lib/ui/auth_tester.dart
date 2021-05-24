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
        backgroundColor: Colors.brown[100],
        elevation: 0,
        title: Text(
          'UPass Authentication',
          style: Styles.blackBoldSmall,
        ),
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
    showEmailDialog();
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
      pp('👿👿👿👿👿 _phoneSignIn:  $e 👿👿');
      AppSnackBar.showErrorSnackBar(scaffoldKey: _key, color: Colors.pink[900], message: '$e');
    }
  }

  showEmailDialog() {
    showDialog(
      context: context, // <<----
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter User Details',
                  style: Styles.greyLabelMedium,
                ),
                EmailAndPassword(onEmailChanged: onEmailChanged, onPasswordChanged: onPasswordChanged),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _startAuth();
                    },
                    child: Text('Sign In')),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String? email, password;
  onEmailChanged(String p1) {
    pp('$mm Email changed: $p1');
    email = p1;
  }

  onPasswordChanged(String p1) {
    pp('$mm Password changed: $p1');
    password = p1;
  }

  void _startAuth() async {
    pp('$mm starting email auth from dialog ...');
    try {
      user = await authService.signInWithEmail(email: email!, password: password!);
      pp('🔴 🔴 Successfully authenticated with 🧡 EMAIL : ${user!.email!}');
      setState(() {
        type = 'Email';
      });
    } catch (e) {
      AppSnackBar.showErrorSnackBar(scaffoldKey: _key, message: '$e');
    }
  }
}

class EmailAndPassword extends StatelessWidget {
  final Function(String) onEmailChanged;
  final Function(String) onPasswordChanged;
  const EmailAndPassword({Key? key, required this.onEmailChanged, required this.onPasswordChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            maxLength: 80,
            onChanged: _onEmailChanged,
            decoration: InputDecoration(
              hintText: 'Enter Email Address',
              labelText: 'Email Address',
            ),
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: passwordController,
            keyboardType: TextInputType.emailAddress,
            maxLength: 80,
            onChanged: _onPasswordChanged,
            decoration: InputDecoration(
              hintText: 'Enter Strong password',
              labelText: 'Password',
            ),
          )
        ],
      ),
    );
  }

  void _onEmailChanged(String value) {
    onEmailChanged(value);
  }

  void _onPasswordChanged(String value) {
    onPasswordChanged(value);
  }
}
