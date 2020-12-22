import 'package:flutter/material.dart';

class EditHomework extends StatefulWidget {
  @override
  _EditHomeworkState createState() => _EditHomeworkState();
}

class _EditHomeworkState extends State<EditHomework> {
  Map data = {};
  var items = [
    0,1,2,3,4
  ];

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(data['title']),
        centerTitle: true,
      ),
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            var a = items[oldIndex];
            items.removeAt(oldIndex);
            items.insert(newIndex, a);
            print(oldIndex.toString() + " " + newIndex.toString());
            print(items);
          });
        },
        children: [
          for (final i in items)
            Dismissible(
              key: ValueKey(i),
              onDismissed: (direction) {
                setState(() {
                  items.remove(i);
                });
              },
              child: ListTile(
                  title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                          "assets/testImage/" + (i + 1).toString() + ".jpg"))),
            )
        ],
      ),
    );
  }
}
