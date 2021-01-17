import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:homework/components/inputPopup.dart';
import 'package:homework/models/document_elements/document_element.dart';
import 'package:homework/models/document_elements/image_doc_element.dart';
import 'package:homework/models/document_elements/text_doc_element.dart';
import 'package:homework/models/hierarchy.dart';
import 'package:homework/models/image_loader.dart';
import 'package:homework/screens/edit_homework/components/add_document_element_menu.dart';
import 'package:homework/screens/edit_homework/components/document_editor.dart';
import 'package:provider/provider.dart';

class EditHomework extends StatefulWidget {
  @override
  _EditHomeworkState createState() => _EditHomeworkState();
}

class _EditHomeworkState extends State<EditHomework> {
  Map _data = {};
  DocumentEditor _editor;
  final controller = TextEditingController();
  Hierarchy hierarchy;
  @override
  Widget build(BuildContext context) {
    _data = ModalRoute
        .of(context)
        .settings
        .arguments;
    hierarchy = Provider.of<Hierarchy>(context);
    var title = _data["homeworkItem"].title;
    _editor = DocumentEditor(_data["homeworkItem"], hierarchy.saveAndRefresh);

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  Flushbar(
                    message: 'Start Sharing',
                    duration: Duration(seconds: 3),
                    backgroundColor: Theme
                        .of(context)
                        .accentColor,
                    leftBarIndicatorColor: Theme
                        .of(context)
                        .primaryColor,
                  )
                    ..show(context);
                  _editor.sharePDF();
                }),
            IconButton(
                icon: Icon(Icons.file_download),
                onPressed: () async {
                  Flushbar(
                    message: 'Downloading...',
                    backgroundColor: Theme
                        .of(context)
                        .accentColor,
                    leftBarIndicatorColor: Theme
                        .of(context)
                        .primaryColor,
                    duration: Duration(seconds: 3),
                  )
                    ..show(context);
                  await _editor.generatePDF();
                  Flushbar(
                    message: 'Downloaded',
                    backgroundColor: Theme
                        .of(context)
                        .accentColor,
                    leftBarIndicatorColor: Theme
                        .of(context)
                        .primaryColor,
                    duration: Duration(seconds: 4),
                  )
                    ..show(context);
                })
          ],
        ),
        body: ListView(
          children: [
            for (final i in _editor.getPages())
              Dismissible(
                key: ValueKey(i),
                onDismissed: (direction) {
                  setState(() {
                    _editor.removePage(i);
                  });
                },
                child: ListTile(
                    title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: generatePage(i))),
              )
          ],
        ),
        floatingActionButton: AddDocumentElementMenu(
            addCameraPhoto: addCameraPhoto,
            addGalleryPhoto: addGalleryPhoto,
            addTextElement: addText));
  }

  Future<void> addCameraPhoto() async {
    String src = await ImageLoader().getImageCamera();
    if (src != null) {
      setState(() {
        _editor.addNewImage(ImageDocElement(src));
      });
    }
  }

  Future<void> addGalleryPhoto() async {
    String src = await ImageLoader().getImageGallery();
    if (src != null) {
      setState(() {
        _editor.addNewImage(ImageDocElement(src));
      });
    }
  }

  Future<void> addText() async {
    inputPopup(context, "New text", "CREATE", controller, () {
      setState(() {
        _editor.addNewText(TextDocElement(controller.text));
      });
    });
  }

  generatePage(DocumentElement pathImage) {
    return Stack(children: [
      GestureDetector(
          onTap: () {
              pathImage.onClick(context,hierarchy.saveAndRefresh);
          },
          child: pathImage.generatePage()),
      Align(
        alignment: Alignment.topRight,
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_circle_up_rounded),
              onPressed: () {
                setState(() {
                  _editor.swapPages(pathImage, true);
                });
              },
              iconSize: 50,
            ),
            IconButton(
              icon: Icon(Icons.arrow_circle_down_rounded),
              onPressed: () {
                setState(() {
                  _editor.swapPages(pathImage, false);
                });
              },
              iconSize: 50,
            ),
          ],
        ),
      )
    ]);
    //     chi )
  }
}
