import 'package:flutter/material.dart';
import 'package:homework/screens/editHomework.dart';
import 'package:homework/screens/home.dart';
import 'package:homework/screens/settings.dart';
import 'package:homework/theme/style.dart';

void main() {
  runApp(MaterialApp(
    title: 'homework',
    theme: MainTheme().theme,
    //initialRoute: '/home',
    routes: {
      '/': (context) =>Home(),
      '/settings': (context) =>Settings(),
      '/editHomework': (context)=>EditHomework()
    },
  ));
}
