import 'package:flutter/material.dart';

class EditHomework extends StatefulWidget {
  @override
  _EditHomeworkState createState() => _EditHomeworkState();
}

class _EditHomeworkState extends State<EditHomework> {
  Map data = {};
  var items = [0, 1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(data['title']),
        centerTitle: true,
      ),
      body: ListView(
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
                      child: generatePage(i))),
            )
        ],
      ),
    );
  }

  generatePage(var i) {
    return Stack(children: [
      Image.asset("assets/testImage/" + (i + 1).toString() + ".jpg"),
      Align(
        alignment: Alignment.topRight,
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_circle_up_rounded),
              onPressed: () {
                swapPages(i, true);
              },
              iconSize: 50,
            ),
            IconButton(
              icon: Icon(Icons.arrow_circle_down_rounded),
              onPressed: () {
                swapPages(i, false);
              },
              iconSize: 50,
            ),
          ],
        ),
      )
    ]);
    //     chi )
  }

  swapPages(int object, bool isUp) {
    setState(() {
      int oldIndex = items.indexOf(object);
      int newIndex = oldIndex + (isUp ? -1 : 1);
      if (newIndex < 0 || newIndex >= items.length) return;
      var temp = items[oldIndex];
      items.removeAt(oldIndex);
      items.insert(newIndex, temp);
    });
  }
}
