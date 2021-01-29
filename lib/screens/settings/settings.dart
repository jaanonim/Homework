import 'package:flutter/material.dart';
import 'package:Homework/models/settings_data.dart';
import 'package:provider/provider.dart';
import 'package:Homework/components/inputPopup.dart';
import 'package:Homework/components/infoPopup.dart';
import 'package:Homework/components/inputSliderPopup.dart';
import 'package:Homework/screens/settings/components/switch_setting.dart';
import 'package:Homework/screens/settings/components/clickable_setting.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final SettingsData data = Provider.of<SettingsData>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
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
            Divider(),
            SwitchSetting(
              title: 'Automatic file name',
              subtitle: 'If is enabled every file will be created with default name',
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
                inputPopup(context, 'Default name for file', 'Ok', controller,
                    () {
                  data.defaultFileName = controller.text;
                });
              },
            ),
            Divider(),
            SwitchSetting(
              title: 'Custom markup',
              subtitle:
                  'Allows you to insert special markups into for e.g. filenames.',
              value: data.customMarkup,
              switchValue: (bool value) {
                data.customMarkup = value;
              },
            ),
            ClickableSetting(
                title: 'About custom markup',
                onClick: () {
                  infoPopup(
                      context,
                      'About markups',
                      'In for e.g. filenames you can use custom markups like: "##date##" to add in this place current date.',
                      'Ok');
                }),
            Divider(),
            SwitchSetting(
              title: 'Default file template',
              subtitle:
                  'If is enabled every file will be created as copy of default file.',
              value: data.enabledDefaultFile,
              switchValue: (bool value) {
                data.enabledDefaultFile = value;
              },
            ),
            ClickableSetting(title: 'Edit default file', onClick: () {
              Navigator.pushNamed(context, "/editHomework",
                  arguments: {"homeworkItem": data.defaultFile, "save": data.saveAndRefresh});
            }),
            Divider(),
            ClickableSetting(
              title: 'Image quality',
              subtitle: data.imgQuality.toString()+"%",
              onClick: () {
                inputSliderPopup(context, "Set image quality:", "Save", data.imgQuality, (v){data.imgQuality=v;});
              },
            ),
            ClickableSetting(
              title: 'Date format',
              subtitle: data.dateFormat,
              onClick: () {
                final controller = TextEditingController();
                controller.text = data.dateFormat;
                inputPopup(
                    context, 'Date format (e.g. dd/MM/yyyy)', 'Ok', controller,
                    () {
                  data.dateFormat = controller.text;
                });
              },
            ),
            Divider(),
            ClickableSetting(
                title: 'Credits',
                onClick: () {
                  infoPopup(
                      context,
                      'Authors:',
                      '- Dominik Wojtasik\n- Mateusz Mrowiec',
                      'Ok');
                }),
            ClickableSetting(
                title: 'License',
                subtitle: 'GNU General Public License v3.0',
                onClick: () {
                  _launchURL("https://raw.githubusercontent.com/jaanonim/Homework/master/LICENSE");
                }),
            ClickableSetting(
                title: 'This project is open source',
                subtitle: "https://github.com/jaanonim/Homework/",
                onClick: () {
                  _launchURL("https://github.com/jaanonim/Homework/");
                }),
          ],
        ));
  }
}
