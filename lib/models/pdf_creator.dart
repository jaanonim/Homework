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

  void createNewPageSrc(String imageSrc) {
    createNewPageByte(File(imageSrc).readAsBytesSync());
  }

  void createNewPageByte(Uint8List file) {
    print(doc);
    final image = PdfImage.file(
      doc.document,
      bytes: file,
    );
    doc.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Image(image, width: widthA4Page),
        ),
      ),
    );
  }

  Future<String> save(String dirName) async {
    //TODO(anyone): chcek if the dirname is safe

    String dirPath = (await _localPath) + "/" + dirName+".pdf";
    new Directory(dirPath).create(recursive: true).then((value) {
      final file = File(dirPath + "/"+dirName+".pdf");
      print(dirPath + "/"+dirName);
      file.writeAsBytesSync(doc.save());
    });
    return dirPath + "/"+dirName+".pdf";
  }
}
