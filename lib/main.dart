import 'package:flutter/material.dart';
import 'package:Homework/models/hierarchy.dart';
import 'package:Homework/screens/edit_homework/edit_homework.dart';
import 'package:Homework/screens/home/home.dart';
import 'package:Homework/screens/settings/settings.dart';
import 'package:Homework/theme/style.dart';
import 'package:provider/provider.dart';
import 'package:Homework/models/settings_data.dart';
import 'package:unity_ads_plugin/unity_ads.dart';

main() {
  runApp(Wrapper());
}

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    UnityAds.init(
        gameId: "4237345",
        testMode: false,
        listener: (state, args) => print('Init Listener: $state => $args')
    );

    return ChangeNotifierProvider<SettingsData>(
      create: (context) => SettingsData(true),
      child: ChangeNotifierProvider<Hierarchy>(
        create: (context) => Hierarchy(),
        child: App(),
      ),
    );
  }
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
