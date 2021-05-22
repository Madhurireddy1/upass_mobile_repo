import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:upass_mobile_repo/data_models/user.dart';
import 'package:upass_mobile_repo/ui/events_page.dart';
import 'package:upass_mobile_repo/ui/geofence_page.dart';
import 'package:upass_mobile_repo/util/functions.dart';
import 'package:upass_mobile_repo/util/functions_and_shit.dart';
import 'package:upass_mobile_repo/util/prefs.dart';

import 'my_page_view_model.dart';

class OnBoardingMobile extends StatefulWidget {
  @override
  _OnBoardingMobileState createState() => _OnBoardingMobileState();
}

class _OnBoardingMobileState extends State<OnBoardingMobile> {
  final introKey = GlobalKey<IntroductionScreenState>();
  var lorem = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, '
      'non tempor felis. Nam rutrum rhoncus est ac venenatis.';
  static const mm = '🖐🏽🖐🏽🖐🏽🖐🏽🖐🏽🖐🏽 🦋 OnBoardingMobile: 🦋 ';
  User? _user;

  @override
  void initState() {
    super.initState();
    _checkUser();
  }
  void _checkUser() async {
    pp('$mm getting the user from shared prefs ... ');
    _user = await  Prefs.getUser();
    if (_user == null) {
      pp('checkUser: 👿 👿 👿 👿 👿 👿 User has not been established yet ...'
          ' 🦠  will prompt to  sign up or in');
    }
  }
  void _onIntroEnd(context) async {
    pp('$mm  _onIntroEnd: ... navigating to somewhere ...🦋 🦋 🦋 🦋 🦋 🦋 🦋 check user status ...');

    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.topLeft,
            duration: Duration(milliseconds: 1000),
            child: GeofencePage()));
  }

  var bodyStyle = TextStyle(fontSize: 19.0);
  var pageDecoration = const PageDecoration(
    titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w900),
    bodyTextStyle: TextStyle(fontSize: 17.0),
    descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    pageColor: Colors.white,
    imagePadding: EdgeInsets.zero,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IntroductionScreen(
          key: introKey,
          globalBackgroundColor: Colors.white,
          globalHeader: Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 4, right: 4),
                child: Image.asset('assets/markers/footprint.png', height: 60, width: 60,),
              ),
            ),
          ),
          globalFooter: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              child: const Text(
                'Let\s go right away!',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w100),
              ),
              onPressed: () => _onIntroEnd(context),
            ),
          ),
          pages: [
            PageViewModel(
              title: "Full Screen Page",
              body:
              "Pages can be full screen as well.\n\n$lorem",
              image: Image.asset(
                'assets//students/students2.jpeg',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
              decoration: pageDecoration.copyWith(
                contentMargin: const EdgeInsets.symmetric(horizontal: 16),
                fullScreen: true,
                bodyFlex: 2,
                imageFlex: 3,
              ),
            ),
            PageViewModel(
              title: "Full Screen Page Uno",
              body:
              "Pages can be full screen as well.\n\n$lorem",
              image: Image.asset(
                'assets//students/students7.jpeg',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
              decoration: pageDecoration.copyWith(
                contentMargin: const EdgeInsets.symmetric(horizontal: 16),
                fullScreen: true,
                bodyFlex: 2,
                imageFlex: 3,
              ),
            ),
            PageViewModel(
              title: "Full Screen Page",
              body:
              "Pages can be full screen as well.\n\n$lorem",
              image: Image.asset(
                'assets//students/students1.jpeg',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
              decoration: pageDecoration.copyWith(
                contentMargin: const EdgeInsets.symmetric(horizontal: 16),
                fullScreen: true,
                bodyFlex: 2,
                imageFlex: 3,
              ),
            ),
            PageViewModel(
              title: "Full Screen Page  2",
              body:
              "Pages can be full screen as well.\n\n$lorem",
              image: Image.asset(
                'assets//students/students8.jpeg',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
              decoration: pageDecoration.copyWith(
                contentMargin: const EdgeInsets.symmetric(horizontal: 16),
                fullScreen: true,
                bodyFlex: 2,
                imageFlex: 3,
              ),
            ),
            PageViewModel(
              title: "Full Screen Page Dujour",
              body:
              "Pages can be full screen as well.\n\n$lorem",
              image: Image.asset(
                'assets//students/students5.jpeg',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
              decoration: pageDecoration.copyWith(
                contentMargin: const EdgeInsets.symmetric(horizontal: 16),
                fullScreen: true,
                bodyFlex: 2,
                imageFlex: 3,
              ),
            ),
            PageViewModel(
              titleWidget: Container(
                width: 300, height: 200,
                color: Colors.transparent,
                child: Column(
                  children: [
                    SizedBox(height: 60,),
                    Text('Thank you for reading', style: Styles.blackBoldMedium,),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: _navigateToSignUp, child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Sign Up'),
                    )),
                  ],
                ),
              ),
              bodyWidget: Container(),
              image: Image.asset(
                'assets//students/students6.png',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
              decoration: pageDecoration.copyWith(
                contentMargin: const EdgeInsets.symmetric(horizontal: 4),
                fullScreen: true,
                bodyFlex: 2,
                imageFlex: 3,
              ),
            ),
          ],
          onDone: () => _onIntroEnd(context),
          onSkip: () => _onIntroEnd(context),
          showSkipButton: true,
          skipFlex: 0,
          nextFlex: 0,
          //rtl: true, // Display as right-to-left
          skip: const Text('Skip'),
          next: const Icon(Icons.arrow_forward),
          done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(16),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Color(0xFFBDBDBD),
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          dotsContainerDecorator: const ShapeDecoration(
            color: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        )
      ],
    );
  }

  void _navigateToSignUp() {
    pp('$mm ............ 🍎 _navigateToSignUp ');
  }
}




