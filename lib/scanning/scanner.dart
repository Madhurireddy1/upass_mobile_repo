import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scan/scan.dart';
import 'package:upass_mobile_repo/util/functions.dart';
import 'package:upass_mobile_repo/util/functions_and_shit.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  static const mm = 'Scanner: 🍐 🍐 🍐 🍐 🍐 ';

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _platformVersion = 'Unknown';

  ScanController scanController = ScanController();
  String? qrcode;
  bool showScanner = true;

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Scan.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Your Friend'),
      ),
      backgroundColor: Colors.brown[100],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Running on: $_platformVersion',
                  style: Styles.greyLabelMedium,
                ),
                SizedBox(
                  height: 8,
                ),
                showScanner
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 300,
                                height: 300,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                                  child: ScanView(
                                    controller: scanController,
                                    scanAreaScale: .7,
                                    scanLineColor: Colors.green.shade400,
                                    onCapture: (data) {
                                      pp('$mm Scanning has completed, scanController.resume() .. 🍎 data: $data  🍎');
                                      scanController.resume();
                                      setState(() {
                                        qrcode = data;
                                        showScanner = false;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 8,
                ),
                qrcode == null
                    ? Container(
                        child: Text(
                          'Scan  not done yet',
                          style: Styles.greyLabelMedium,
                        ),
                      )
                    : Container(
                        height: 260,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 24,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Scanned',
                                    style: Styles.greyLabelLarge,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Flexible(
                                    child: Text(
                                      '$qrcode',
                                      style: Styles.tealBoldSmall,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  ElevatedButton(onPressed: _handleData, child: Text('Handle Data')),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleData() {
    pp('$mm handling the user data received from scan: 😡 $qrcode 😡 ');
    scanController.resume();
    setState(() {
      showScanner = true;
      qrcode = null;
    });
    pp('$mm state has been set : 😡 scanController.resume() has been run 😡 ');
  }
}
