import 'package:flutter/material.dart';

class ClickableSetting extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onClick;
  ClickableSetting({this.title,this.subtitle,this.onClick});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        onClick();
      },
    );
  }
}
