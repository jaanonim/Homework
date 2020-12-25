import 'package:flutter/material.dart';
import 'package:homework/components/menu.dart';
import 'package:homework/models/homework_item.dart';
import 'package:homework/components/item.dart';

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
    HomeworkItem(title: "s"),
  ];

  createNewDoc(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                  "Create new homework:",
                  style: Theme.of(context).textTheme.headline6,
                ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 25),
            content: TextField(
              controller: TextEditingController(),
            ),
            actions: [
              MaterialButton(
                onPressed: () {},
                elevation: 5,
                child: Text('Create'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("homework"),
        centerTitle: true,
      ),
      drawer: Menu(),
      body: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          padding: const EdgeInsets.all(5),
          childAspectRatio: 0.7072,
          children: homeworks.map<Widget>((homework) {
            return Item(
              homeworkItem: homework,
              
            );
          }).toList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewDoc(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
