import 'package:flutter/material.dart';
import 'package:homework/components/inputPopup.dart';
import 'package:homework/components/menu.dart';
import 'package:homework/models/hierarchy.dart';
import 'package:homework/models/homework_item.dart';
import 'package:homework/screens/home/components/body.dart';
import 'package:homework/screens/home/components/hierarchy_element.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Hierarchy hierarchy = Provider.of<Hierarchy>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Homework"),
        centerTitle: true,
        bottom: PreferredSize(
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: hierarchy.hierarchy
                      .map((element) => HierarchyElement(
                            folder: element,
                            isLast: element == hierarchy.now,
                          ))
                      .toList())),
          preferredSize: Size.fromHeight(40),
        ),
      ),
      drawer: Menu(),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          inputPopup(context, "Create new homework:", "Create", controller, () {
            HomeworkItem item = hierarchy.createFile(controller.text);
            Navigator.pop(context);
            Navigator.pushNamed(context, "/editHomework",
                arguments: {"homeworkItem": item});
          });
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
