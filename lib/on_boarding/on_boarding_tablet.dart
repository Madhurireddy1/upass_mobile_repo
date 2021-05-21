import 'package:flutter/material.dart';

class OnBoardingTablet extends StatefulWidget {
  @override
  _OnBoardingTabletState createState() => _OnBoardingTabletState();
}

class _OnBoardingTabletState extends State<OnBoardingTablet>
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
        title: Text('OnBoardingTablet'),
      ),
    );
  }
}
