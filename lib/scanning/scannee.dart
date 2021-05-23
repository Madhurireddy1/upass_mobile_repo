import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:upass_mobile_repo/data_models/user.dart';
import 'package:upass_mobile_repo/util/functions.dart';
import 'package:uuid/uuid.dart';

class Scannee extends StatefulWidget {
  const Scannee({Key? key}) : super(key: key);

  @override
  _ScanneeState createState() => _ScanneeState();
}

class _ScanneeState extends State<Scannee> {
  var uuid = Uuid().v4();
  User? fakeUser;
  @override
  void initState() {
    super.initState();
    fakeUser = User(
        email: 'aubrey@aftarobot.com',
        cellphone: '065 591  7675',
        token: 'TBD',
        date: DateTime.now().toIso8601String(),
        userId: uuid.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(('Follow Me Now')),
      ),
      backgroundColor: Colors.brown[100],
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
                        'Scan Me!',
                        style: Styles.greyLabelMedium,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      QrImage(
                        data: fakeUser == null ? "" : fakeUser!.toJson().toString(),
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
