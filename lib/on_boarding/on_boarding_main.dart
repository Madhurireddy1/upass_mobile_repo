import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:upass_mobile_repo/on_boarding/on_boarding_mobile.dart';
import 'package:upass_mobile_repo/on_boarding/on_boarding_tablet.dart';

class OnBoardingMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: OnBoardingMobile(),
        tablet: OnBoardingTablet());
  }
}
