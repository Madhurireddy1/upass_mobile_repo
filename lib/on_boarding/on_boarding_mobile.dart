import 'package:flutter/material.dart';

class OnBoardingMobile extends StatefulWidget {
  @override
  _OnBoardingMobileState createState() => _OnBoardingMobileState();
}

class _OnBoardingMobileState extends State<OnBoardingMobile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OnBoardingMobile'),
      ),
    );
  }
}
