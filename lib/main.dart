import 'package:flutter/material.dart';
import 'package:homework/screens/edit_homework/edit_homework.dart';
import 'package:homework/screens/home/home.dart';
import 'package:homework/screens/settings/settings.dart';
import 'package:homework/theme/style.dart';

main() {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'homework',
    theme: MainTheme().theme,
    //initialRoute: '/home',
    routes: {
      '/': (context) =>Home(),
      '/settings': (context) =>Settings(),
      '/editHomework': (context) =>EditHomework(),
    },
  ));
}
