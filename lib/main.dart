import 'package:flutter/material.dart';
import 'package:homework/models/hierarchy.dart';
import 'package:homework/screens/edit_homework/edit_homework.dart';
import 'package:homework/screens/home/home.dart';
import 'package:homework/screens/settings/settings.dart';
import 'package:homework/theme/style.dart';
import 'package:provider/provider.dart';

main() {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider<Hierarchy>(
    create: (context) => Hierarchy(),
    child: MaterialApp(
      title: 'homework',
      theme: MainTheme().theme,
      //initialRoute: '/home',
      routes: {
        '/': (context) => Home(),
        '/settings': (context) => Settings(),
        '/editHomework': (context) => EditHomework(),
      },
    ),
  ));
}
