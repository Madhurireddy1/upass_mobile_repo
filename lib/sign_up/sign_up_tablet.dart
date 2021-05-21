import 'package:flutter/material.dart';

class SignUpTablet extends StatefulWidget {
  @override
  _SignUpTabletState createState() => _SignUpTabletState();
}

class _SignUpTabletState extends State<SignUpTablet>
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
        title: Text('SignUpTablet'),
      ),
    );
  }
}
