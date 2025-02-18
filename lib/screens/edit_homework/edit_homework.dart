import 'package:Homework/components/adBar.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:Homework/components/inputPopup.dart';
import 'package:Homework/models/document_elements/document_element.dart';
import 'package:Homework/models/document_elements/image_doc_element.dart';
import 'package:Homework/models/document_elements/text_doc_element.dart';
import 'package:Homework/models/image_loader.dart';
import 'package:Homework/screens/edit_homework/components/add_document_element_menu.dart';
import 'package:Homework/models/document_editor.dart';
import 'package:provider/provider.dart';
import 'package:Homework/models/settings_data.dart';

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
    String _title = _data["homeworkItem"].title;
    _editor = DocumentEditor(_data["homeworkItem"], _data["save"]);

    return Scaffold(
        appBar: AppBar(
          title: InkWell(
              onTap: () {
                controller.text = _title;
                inputPopup(context, "Rename homework", "Rename", controller, () {
                  if (controller.text == "") {
                    Navigator.pop(context);
                    setState(() {
                      _editor.rename(controller.text);
                    });
                  } else {
                    Flushbar(
                      message: "You must enter name.",
                      backgroundColor: Colors.red,
                      leftBarIndicatorColor: Colors.redAccent,
                      duration: Duration(seconds: 2),
                    )..show(context);
                  }
                });
              },
              child: Text(_title)),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () async {
                  Flushbar(
                    message: 'Sharing...',
                    duration: Duration(seconds: 3),
                    backgroundColor: Theme.of(context).accentColor,
                    leftBarIndicatorColor: Theme.of(context).primaryColor,
                  )..show(context);
                  await Future.delayed(Duration(seconds: 1), () async {
                    await _editor.sharePDF();
                  });
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
                  await Future.delayed(Duration(seconds: 1), () async {
                    await _editor.savePDF(true);
                  });
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
            addTextElement: addText),
        bottomNavigationBar: AdBar()
    );
  }

  Future<void> addCameraPhoto() async {
    String src = await ImageLoader()
        .getImageCamera(_settings == null ? 50 : _settings.imgQuality);
    if (src != null) {
      setState(() {
        _editor.addNewImage(ImageDocElement(imageSrc: src, direction: 0));
      });
    }
  }

  Future<void> addGalleryPhoto() async {
    String src = await ImageLoader()
        .getImageGallery(_settings == null ? 50 : _settings.imgQuality);
    if (src != null) {
      setState(() {
        _editor.addNewImage(ImageDocElement(imageSrc: src, direction: 0));
      });
    }
  }

  Future<void> addText() async {
    controller.text = "";
    inputPopup(context, "New text", "Create", controller, () {
      Navigator.pop(context);
      setState(() {
        _editor.addNewText(TextDocElement(controller.text));
      });
    });
  }

  generatePage(DocumentElement pathImage) {
    return Stack(children: [
      InkWell(
          onTap: () {
            pathImage.onClick(context, () {
              setState(() {
                _data["save"]();
              });
            });
          },
          child: pathImage.generatePage(() {
            setState(() {
              _data["save"]();
            });
          }, context)),
      Align(
        alignment: Alignment.topRight,
        child: Column(
          children: [
            MaterialButton(
              onPressed: () {
                setState(() {
                  _editor.swapPages(pathImage, true);
                });
              },
              elevation: 10.0,
              color: Theme.of(context).accentColor,
              child: Icon(
                Icons.arrow_upward_rounded,
                size: 25.0,
              ),
              shape: CircleBorder(),
              minWidth: 0,
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  _editor.removePage(pathImage);
                });
              },
              elevation: 10.0,
              color: Theme.of(context).accentColor,
              child: Icon(
                Icons.delete_rounded,
                size: 25.0,
              ),
              shape: CircleBorder(),
              minWidth: 0,
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  _editor.swapPages(pathImage, false);
                });
              },
              elevation: 10.0,
              color: Theme.of(context).accentColor,
              child: Icon(
                Icons.arrow_downward_rounded,
                size: 25.0,
              ),
              shape: CircleBorder(),
              minWidth: 0,
            ),
          ],
        ),
      )
    ]);
    //     chi )
  }
}
