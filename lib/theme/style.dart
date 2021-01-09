import 'package:flutter/material.dart';

class MainTheme {
  ThemeData get darkTheme => ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.cyan[700],
      accentColor: Colors.cyanAccent[700],
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 24.0),
        bodyText1: TextStyle(fontSize: 16.0, fontFamily: 'Hind'),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
      dividerTheme: DividerThemeData(
        indent: 15,
        endIndent: 15,
      ));

  ThemeData get lightTheme => ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.cyan[700],
      accentColor: Colors.cyanAccent[700],
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 24.0),
        bodyText1: TextStyle(fontSize: 16.0, fontFamily: 'Hind'),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
      dividerTheme: DividerThemeData(
        indent: 15,
        endIndent: 15,
      ));
}
