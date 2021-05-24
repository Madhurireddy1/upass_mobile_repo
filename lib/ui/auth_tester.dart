import 'package:flutter/material.dart';
import 'package:flutter_auth_ui/flutter_auth_ui.dart';
import 'package:upass_mobile_repo/data_models/user.dart';
import 'package:upass_mobile_repo/services/auth_firebase.dart';
import 'package:upass_mobile_repo/util/functions.dart';
import 'package:upass_mobile_repo/util/functions_and_shit.dart';

class AuthenticationStarter extends StatefulWidget {
  const AuthenticationStarter({Key? key}) : super(key: key);
  static const mm = 'AuthTester: 💙 💙 💙 💙 💙 : ';

  @override
  State<AuthenticationStarter> createState() => _AuthenticationStarterState();
}

class _AuthenticationStarterState extends State<AuthenticationStarter> {
  bool result = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Authentication Starter',
          style: Styles.whiteSmall,
        ),
      ),
      backgroundColor: Colors.brown[100],
      body: Stack(
        children: [
          result
              ? Container()
              : Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.amber[100],
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.teal, elevation: 24),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Start Auth",
                          style: Styles.whiteBoldMedium,
                        ),
                      ),
                      onPressed: () async {
                        final providers = [
                          // AuthUiProvider.anonymous,
                          AuthUiProvider.email,
                          AuthUiProvider.phone,
                          // AuthUiProvider.apple,
                          // AuthUiProvider.facebook,
                          // AuthUiProvider.github,
                          AuthUiProvider.google,
                          // AuthUiProvider.twitter,
                          // AuthUiProvider.microsoft,
                          // AuthUiProvider.yahoo,
                        ];
                        await _startAuthenticationUI(providers);
                      },
                    ),
                  ),
                ),
          result
              ? Center(
                  child: Card(
                    elevation: 24,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 200,
                        width: 300,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 48,
                            ),
                            Text(
                              'Authentication',
                              style: Styles.blackBoldLarge,
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Text(
                              'Success!!',
                              style: Styles.pinkBoldLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Still waiting for authentication ...',
                        style: Styles.greyLabelMedium,
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Future<void> _startAuthenticationUI(List<AuthUiProvider> providers) async {
    pp('${AuthenticationStarter.mm} starting to dance ....');
    providers.forEach((element) {
      pp('${AuthenticationStarter.mm} PROVIDER: 💀  ${element.toString()}');
    });
    result = await FlutterAuthUi.startUi(
      items: providers,
      tosAndPrivacyPolicy: TosAndPrivacyPolicy(
        tosUrl: "https://www.google.com",
        privacyPolicyUrl: "https://www.google.com",
      ),
      androidOption: AndroidOption(
        enableSmartLock: false, // default true
        showLogo: true, // default false
        overrideTheme: true, // default false
      ),
      emailAuthOption: EmailAuthOption(
        requireDisplayName: true, // default true
        enableMailLink: false, // default false
        handleURL: '',
        androidPackageName: '',
        androidMinimumVersion: '',
      ),
    );
    pp('${AuthenticationStarter.mm} Result from Auth UI: 🌸  🌸 🌸 🌸 : $result 💦');
    setState(() {});
  }
}

class UpassAuth extends StatefulWidget {
  const UpassAuth({Key? key}) : super(key: key);

  @override
  _UpassAuthState createState() => _UpassAuthState();
}

class _UpassAuthState extends State<UpassAuth> {
  User? user;
  String type = 'NotKnownYet';
  static const mm = 'UpassAuth: 💙 💙 💙 💙 💙 : ';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    user = await authService.signInFacebook();
    pp('🔴 🔴 Successfully authenticated with 🧡 FACEBOOK : ${user!.email!}');
    setState(() {
      type = 'Facebook';
    });
  }

  void _googleSignIn() async {
    pp('$mm Signing on with Google ....');
    user = await authService.signInWithGoogle();
    pp('🔴 🔴 Successfully authenticated with 🧡 GOOGLE : ${user!.email!}');
    setState(() {
      type = 'Google';
    });
  }

  void _twitterSignIn() async {
    pp('$mm Signing on with Twitter ....');
    user = await authService.signInWithTwitter();
    pp('🔴 🔴 Successfully authenticated with 🧡 TWITTER : ${user!.email!}');
    setState(() {
      type = 'Twitter';
    });
  }

  void _emailSignIn() async {
    pp('$mm Signing on with Email ....');
    // user = await authService.signInWithEmail(email: 'aubrey@aftarobot.com', password: 'matimba23#');
    user = await authService.signInWithEmail(email: 'republican@aftarobot.com', password: 'matimba23#');

    pp('🔴 🔴 Successfully authenticated with 🧡 EMAIL : ${user!.email!}');
    setState(() {
      type = 'Email';
    });
  }

  void _phoneSignIn() async {
    pp('$mm Signing on with Phone ....');
    user = await authService.signInWithPhone();
    pp('🔴 🔴 Successfully authenticated with 🧡 PHONE : ${user!.email!}');
    setState(() {
      type = 'Phone';
    });
  }
}
