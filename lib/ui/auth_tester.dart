import 'package:flutter/material.dart';
import 'package:flutter_auth_ui/flutter_auth_ui.dart';
import 'package:upass_mobile_repo/util/functions.dart';
import 'package:upass_mobile_repo/util/functions_and_shit.dart';


class AuthTester extends StatefulWidget {
  const AuthTester({Key? key}) : super(key: key);
 static const mm = 'AuthTester: 💙 💙 💙 💙 💙 : ';

  @override
  State<AuthTester> createState() => _AuthTesterState();
}

class _AuthTesterState extends State<AuthTester> {
  bool result = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Authentication  Tester'),
        ),
        backgroundColor: Colors.brown[100],
        body: Stack(
          children: [
            result? Container() : Center(
              child: Container(width: 200, height: 200, color: Colors.amber[100],
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      elevation: 24
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Start Auth", style: Styles.whiteBoldMedium,),
                  ),
                  onPressed: () async {
                    final providers = [
                      AuthUiProvider.anonymous,
                      AuthUiProvider.email,
                      AuthUiProvider.phone,
                      AuthUiProvider.apple,
                      AuthUiProvider.github,
                      AuthUiProvider.google,
                      AuthUiProvider.microsoft,
                      AuthUiProvider.yahoo,
                    ];
                    await _startAuthenticationUI(providers);
                  },
                ),
              ),
            ),
            result? Center(
              child: Card(elevation: 24,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 200, width: 300,
                  child: Column(
                    children: [
                      SizedBox(height: 48,),
                      Text('Authentication', style: Styles.blackBoldLarge,),
                      SizedBox(height: 24,),
                      Text('Success!!', style: Styles.pinkBoldLarge,),
                    ],
                  ),
                ),
              ),
              ),
            ) : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(elevation:4, child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Still waiting for authentication ...', style: Styles.greyLabelMedium,),
              ),
              ),
            )
          ],
        ),
      ),
    );
  }



  Future<void> _startAuthenticationUI(List<AuthUiProvider> providers) async {
    pp('${AuthTester.mm} starting to dance ....');
    providers.forEach((element) {
      pp('${AuthTester.mm} PROVIDER: 💀  ${element.toString()}');
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
    pp('${AuthTester.mm} Result from Auth UI: 🌸  🌸 🌸 🌸 : $result 💦');
    setState(() {

    });
  }
}
