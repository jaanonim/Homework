import 'package:flutter/material.dart';
import 'package:homework/components/menu.dart';
import 'package:homework/models/homeworkItem.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<HomeworkItem> homeworks = [
    HomeworkItem(title: "a"),
    HomeworkItem(title: "b"),
    HomeworkItem(title: "c"),
    HomeworkItem(title: "d"),
    HomeworkItem(title: "g"),
    HomeworkItem(title: "s"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("homework"),
        centerTitle: true,
      ),
      drawer: Menu(),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        children: homeworks.map<Widget>((obj){
          return Card(
            child: Center(child: Text(obj.title)),
          );
        }).toList()
      ),
    );
  }
}
