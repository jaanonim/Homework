import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:ext_storage/ext_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart' show rootBundle;

class PdfCreator {
  final double widthA4Page = 841;
  var doc = pw.Document();

  Future<bool> _requestPermissions() async {
    return await Permission.storage.request().isGranted;
  }

  Future<String> get _localPath async {
    String path;
    if (Platform.isAndroid) {
      path = await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_DOWNLOADS);
    } else {
      Directory directory = await getDownloadsDirectory();
      path = directory.path;
    }
    return path;
  }

  void createNewPageSrc(String text, String imageSrc, int direction) async {
    createNewPageByte(text, File(imageSrc), direction);
  }

  void createNewPageText(String text) async {
    final ttf = pw.Font.ttf(await rootBundle.load("assets/OpenSans.ttf"));

    doc.addPage(
      pw.Page(
          build: (pw.Context context) => pw.Center(
                child:
                    pw.Text(text, style: pw.TextStyle(fontSize: 30, font: ttf)),
              )),
    );
  }

  void createNewPageByte(String text, file, int direction) async {
    var data = file.readAsBytesSync();
    if(direction%4==0) {
      var decodedImg = img.decodeImage(data);
      decodedImg = img.copyRotate(decodedImg, direction * 90);
      data = img.encodeJpg(decodedImg);
    }

    final image = PdfImage.file(
      doc.document,
      bytes: data,
    );

    doc.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Stack(children: [
            pw.Image(image, fit: pw.BoxFit.fill),
            pw.Align(
                alignment: pw.Alignment.topCenter,
                child: pw.Text(text, style: pw.TextStyle(fontSize: 30))),
          ]),
        ),
      ),
    );
  }

  Future<String> save(String dirName) async {
    if (!await _requestPermissions()) {
      print("Permissions error!");
      return null;
    }
    String dirPath = (await _localPath);
    new Directory(dirPath).create(recursive: true).then((value) {
      final file = File(dirPath + "/" + dirName + ".pdf");
      file.writeAsBytesSync(doc.save());
    });
    return dirPath + "/" + dirName + ".pdf";
  }
}
