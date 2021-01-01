import 'package:flutter/material.dart';
import 'package:homework/models/settings_data.dart';
import 'package:provider/provider.dart';
import 'package:homework/components/inputPopup.dart';
import 'package:homework/screens/settings/components/switch_setting.dart';
import 'package:homework/screens/settings/components/clickable_setting.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SettingsData data = Provider.of<SettingsData>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            SwitchSetting(
              title: 'Dark theme',
              value: data.boolTheme,
              switchValue: (bool value) {
                data.boolTheme = value;
              },
            ),
            SwitchSetting(
              title: 'Automatic file name',
              value: data.automaticFileName,
              switchValue: (bool value) {
                data.automaticFileName = value;
              },
            ),
            ClickableSetting(
              title: 'Default file name',
              subtitle: data.defaultFileName,
              onClick: () {
                final controller = TextEditingController();
                controller.text = data.defaultFileName;
                inputPopup(context, "Default name for file", "Ok", controller, (){
                  data.defaultFileName = controller.text;
                });
              },
            )
          ],
        ));
  }
}
