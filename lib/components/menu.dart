import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 120.0,
            child: DrawerHeader(
              child: Center(
                child: Text('U are the best!',
                    style: Theme.of(context).textTheme.headline6),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, "/settings");
            },
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Trash'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
