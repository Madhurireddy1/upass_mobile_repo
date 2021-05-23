import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:upass_mobile_repo/util/functions.dart';

class Scannee extends StatefulWidget {
  const Scannee({Key? key}) : super(key: key);

  @override
  _ScanneeState createState() => _ScanneeState();
}

class _ScanneeState extends State<Scannee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(('Get My Friend to Scan Me')),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 300,
              height: 360,
              child: Card(
                elevation: 24,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        'Be Scanned!',
                        style: Styles.greyLabelMedium,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      QrImage(
                        data: "1234567890",
                        version: QrVersions.auto,
                        size: 240.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
