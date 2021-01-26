import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:homework/components/inputPopup.dart';
import 'package:homework/models/document_elements/document_element.dart';
import 'package:homework/models/document_elements/image_doc_element.dart';
import 'package:homework/models/document_elements/text_doc_element.dart';
import 'package:homework/models/image_loader.dart';
import 'package:homework/screens/edit_homework/components/add_document_element_menu.dart';
import 'package:homework/models/document_editor.dart';
import 'package:provider/provider.dart';
import 'package:homework/models/settings_data.dart';

class EditHomework extends StatefulWidget {
  @override
  _EditHomeworkState createState() => _EditHomeworkState();
}

class _EditHomeworkState extends State<EditHomework> {
  Map _data = {};
  DocumentEditor _editor;
  final controller = TextEditingController();
  SettingsData _settings;


  @override
  Widget build(BuildContext context) {
    _settings = Provider.of<SettingsData>(context);
    _data = ModalRoute.of(context).settings.arguments;
    var title = _data["homeworkItem"].title;
    _editor = DocumentEditor(_data["homeworkItem"], _data["save"]);

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  Flushbar(
                    message: 'Sharing...',
                    duration: Duration(seconds: 3),
                    backgroundColor: Theme.of(context).accentColor,
                    leftBarIndicatorColor: Theme.of(context).primaryColor,
                  )..show(context);
                  _editor.sharePDF();
                }),
            IconButton(
                icon: Icon(Icons.file_download),
                onPressed: () async {
                  Flushbar(
                    message: 'Downloading...',
                    backgroundColor: Theme.of(context).accentColor,
                    leftBarIndicatorColor: Theme.of(context).primaryColor,
                    duration: Duration(seconds: 3),
                  )..show(context);
                  await _editor.generatePDF();
                  Flushbar(
                    message: 'Downloaded',
                    backgroundColor: Theme.of(context).accentColor,
                    leftBarIndicatorColor: Theme.of(context).primaryColor,
                    duration: Duration(seconds: 4),
                  )..show(context);
                })
          ],
        ),
        body: ListView(
          children: [
            for (final i in _editor.getPages())
              ListTile(
                  title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: generatePage(i)))
          ],
        ),
        floatingActionButton: AddDocumentElementMenu(
            addCameraPhoto: addCameraPhoto,
            addGalleryPhoto: addGalleryPhoto,
            addTextElement: addText));
  }

  Future<void> addCameraPhoto() async {
    String src = await ImageLoader().getImageCamera(_settings == null ? 50 : _settings.imgQuality);
    if (src != null) {
      setState(() {
        _editor.addNewImage(ImageDocElement(src));
      });
    }
  }

  Future<void> addGalleryPhoto() async {
    String src = await ImageLoader().getImageGallery(_settings == null ? 50 : _settings.imgQuality);
    if (src != null) {
      setState(() {
        _editor.addNewImage(ImageDocElement(src));
      });
    }
  }

  Future<void> addText() async {
    inputPopup(context, "New text", "Create", controller, () {
      setState(() {
        _editor.addNewText(TextDocElement(controller.text));
      });
    });
  }

  generatePage(DocumentElement pathImage) {
    return Stack(children: [
      GestureDetector(
          onTap: () {
            pathImage.onClick(context, _data["save"]);
          },
          child: pathImage.generatePage()),
      Align(
        alignment: Alignment.topRight,
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_upward_rounded),
              onPressed: () {
                setState(() {
                  _editor.swapPages(pathImage, true);
                });
              },
              iconSize: 40,
            ),
            IconButton(
              icon: Icon(Icons.delete_rounded),
              onPressed: () {
                setState(() {
                  _editor.removePage(pathImage);
                });
              },
              iconSize: 40,
            ),
            IconButton(
              icon: Icon(Icons.arrow_downward_rounded),
              onPressed: () {
                setState(() {
                  _editor.swapPages(pathImage, false);
                });
              },
              iconSize: 40,
            ),
          ],
        ),
      )
    ]);
    //     chi )
  }
}
