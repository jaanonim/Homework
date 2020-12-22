import 'package:flutter/material.dart';
import 'file:///E:/Mateusz/dodatki/PROGRAMOWANIE/flutter/homework/lib/screens/home/home.dart';
import 'file:///E:/Mateusz/dodatki/PROGRAMOWANIE/flutter/homework/lib/screens/settings/settings.dart';
import 'package:homework/theme/style.dart';

void main() {
  runApp(MaterialApp(
    title: 'homework',
    theme: MainTheme().theme,
    //initialRoute: '/home',
    routes: {
      '/': (context) =>Home(),
      '/settings': (context) =>Settings(),
    },
  ));
}
