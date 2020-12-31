import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homework/models/settings_data.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final SettingsData data = Provider.of<SettingsData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(children: [
        MergeSemantics(
          child: ListTile(
            title: Text('Experimantal fhuture'),
            trailing: CupertinoSwitch(
              value: data.isActive,
              onChanged: (bool value) { data.setActive(value); },
              activeColor: Theme.of(context).accentColor,
            ),
            onTap: () {data.setActive(!data.isActive);},
          ),
        )
      ],)
    );
  }
}