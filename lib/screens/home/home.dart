import 'package:flutter/material.dart';
import 'package:homework/components/inputPopup.dart';
import 'package:homework/models/hierarchy.dart';
import 'package:homework/models/homework_item.dart';
import 'package:homework/screens/home/components/body.dart';
import 'package:homework/screens/home/components/hierarchy_element.dart';
import 'package:provider/provider.dart';
import 'package:homework/models/settings_data.dart';
import 'package:homework/models/custom_markups.dart';

class Home extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Hierarchy hierarchy = Provider.of<Hierarchy>(context);
    final SettingsData data = Provider.of<SettingsData>(context);

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
        actions: [
        IconButton(
          icon: Icon(Icons.settings),
          onPressed:(){
            Navigator.pushNamed(context, "/settings");
          },
          ),
        ],
      ),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (data.automaticFileName) {
            controller.text = data.defaultFileName;
          }
          inputPopup(context, "Create new homework:", "Create", controller, () {
            HomeworkItem item = hierarchy.createFile(data.customMarkup ? useMarkups(controller.text, data) : controller.text);
            Navigator.pushNamed(context, "/editHomework",
                arguments: {"homeworkItem": item});
          });
        },
        child: Icon(
          Icons.add,
          size: 32,
        ),
      ),
    );
  }
}
