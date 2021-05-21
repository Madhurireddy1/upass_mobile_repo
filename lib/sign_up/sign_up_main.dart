import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:upass_mobile_repo/sign_up/sign_up_mobile.dart';
import 'package:upass_mobile_repo/sign_up/sign_up_tablet.dart';

class SignUpMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: SignUpMobile(),
      tablet: SignUpTablet(),
    );
  }
}
