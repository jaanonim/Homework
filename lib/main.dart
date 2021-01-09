import 'package:flutter/material.dart';
import 'package:homework/models/hierarchy.dart';
import 'package:homework/screens/edit_homework/edit_homework.dart';
import 'package:homework/screens/home/home.dart';
import 'package:homework/screens/settings/settings.dart';
import 'package:homework/theme/style.dart';
import 'package:provider/provider.dart';
import 'package:homework/models/settings_data.dart';

main() {
  runApp(ChangeNotifierProvider<SettingsData>(
    create: (context) => SettingsData(true),
    child: ChangeNotifierProvider<Hierarchy>(
      create: (context) => Hierarchy(),
      child: App(),
    ),
  ));
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final SettingsData data = Provider.of<SettingsData>(context);

    return MaterialApp(
      title: 'homework',
      theme: MainTheme().lightTheme,
      darkTheme: MainTheme().darkTheme,
      themeMode: data.theme,
      //initialRoute: '/home',
      routes: {
        '/': (context) => Home(),
        '/settings': (context) => Settings(),
        '/editHomework': (context) => EditHomework(),
      },
    );
  }
}
