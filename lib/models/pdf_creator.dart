import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfCreator {
  final double widthA4Page = 841;
  var doc = pw.Document();

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();

    return directory.path;
  }

  void createNewPageSrc(String text, String imageSrc) {
    createNewPageByte(text, File(imageSrc).readAsBytesSync());
  }

  void createNewPageByte(String text, Uint8List file) {
    print(doc);
    final image = PdfImage.file(
      doc.document,
      bytes: file,
    );
    doc.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Stack(children: [
            pw.Image(image, fit: pw.BoxFit.fill),
            pw.Align(alignment: pw.Alignment.topCenter, child: pw.Text(text,style: pw.TextStyle(fontSize: 30))),
          ]),
          // pw.Text(text, textAlign: pw.TextAlign.center),
        ),
      ),
    );
  }

  Future<String> save(String dirName) async {
    //TODO(anyone): chcek if the dirname is safe

    String dirPath = (await _localPath) + "/" + dirName + ".pdf";
    new Directory(dirPath).create(recursive: true).then((value) {
      final file = File(dirPath + "/" + dirName + ".pdf");
      print(dirPath + "/" + dirName);
      file.writeAsBytesSync(doc.save());
    });
    return dirPath + "/" + dirName + ".pdf";
  }
}
