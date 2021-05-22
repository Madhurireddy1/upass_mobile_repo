import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:upass_mobile_repo/util/functions_and_shit.dart';

class MySettingsPageMobile extends StatefulWidget {
  const MySettingsPageMobile({Key? key}) : super(key: key);

  @override
  _MySettingsPageMobileState createState() => _MySettingsPageMobileState();
}

class _MySettingsPageMobileState extends State<MySettingsPageMobile> {

  bool value = false;
  static const mm = 'Settings: 😎 😎 😎 😎 :  ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Settings'),
      ),
      backgroundColor: Colors.brown[100],
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SettingsList(
              sections: [
                SettingsSection(
                  title: 'Privacy',
                  tiles: [
                    SettingsTile(
                      title: 'Language',
                      subtitle: 'English',
                      leading: Icon(Icons.language),
                      onPressed: (BuildContext context) {},
                    ),
                    SettingsTile.switchTile(
                      title: 'Use fingerprint',
                      leading: Icon(Icons.fingerprint),
                      switchValue: value,
                      onToggle: (bool value) {
                        pp('$mm  Fingerprint toggled? 😎 $value 😎 ');
                        setState(() {
                          this.value = value;
                        });
                      },
                    ),
                    SettingsTile.switchTile(
                      title: 'Notify Authorities',
                      leading: Icon(Icons.local_police),
                      switchValue: value,
                      onToggle: (bool value) {
                        pp('$mm  Notify Authorities toggled? 😎 $value 😎 ');
                        setState(() {
                          this.value = value;
                        });
                      },
                    ),
                  ],
                ),
                SettingsSection(
                  title: 'Tracking',
                  tiles: [
                    SettingsTile(
                      title: 'Language',
                      subtitle: 'English',
                      leading: Icon(Icons.language),
                      onPressed: (BuildContext context) {},
                    ),
                    SettingsTile.switchTile(
                      title: 'Use fingerprint',
                      leading: Icon(Icons.fingerprint),
                      switchValue: value,
                      onToggle: (bool value) {
                        pp('$mm  Fingerprint toggled? 😎 $value 😎 ');
                        setState(() {
                          this.value = value;
                        });
                      },
                    ),
                    SettingsTile.switchTile(
                      title: 'Notify Authorities',
                      leading: Icon(Icons.local_police),
                      switchValue: value,
                      onToggle: (bool value) {
                        pp('$mm  Notify Authorities toggled? 😎 $value 😎 ');
                        setState(() {
                          this.value = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
