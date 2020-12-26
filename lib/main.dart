import 'package:flutter/material.dart';
import 'file:///C:/Users/n2one/projekty/IdeaProjects/android/homework/lib/screens/edit_homework/edit_homework.dart';
import 'package:homework/screens/home/home.dart';
import 'package:homework/screens/settings/settings.dart';
import 'package:homework/theme/style.dart';

void main() {
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
