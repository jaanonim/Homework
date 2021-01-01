import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SwitchSetting extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final Function(bool) switchValue;
  SwitchSetting({this.title,this.subtitle,this.value,this.switchValue});

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: ListTile(
        title: Text(title),
        trailing: CupertinoSwitch(
          value: value,
          onChanged: (bool value) {
            switchValue(value);
          },
          activeColor: Theme.of(context).accentColor,
        ),
        onTap: () {
          switchValue(!value);
        },
      ),
    );
  }
}
