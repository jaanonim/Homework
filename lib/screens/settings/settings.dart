import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(children: <Widget>[
        ListTile(
          title: Text('Enable Feature'),
          trailing: Checkbox(
            value: true,
            onChanged: (val) {
              setState(() {

              });
            },
          ),
          onTap: () {
            setState(() {   });
          },
        )
      ]),
    );
  }
}
