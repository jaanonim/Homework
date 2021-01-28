import 'dart:io';
import 'dart:typed_data';
import 'package:ext_storage/ext_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class PdfCreator {
  final double widthA4Page = 841;
  var doc = pw.Document();

  Future<bool> _requestPermissions() async {
    return await Permission.storage.request().isGranted;
  }

  Future<String> get _localPath async {
    String path;
    if (Platform.isAndroid) {
      path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    } else {
      Directory directory = await getDownloadsDirectory();
      path = directory.path;
    }
    return path;
  }

  void createNewPageSrc(String text, String imageSrc) {
    createNewPageByte(text, File(imageSrc).readAsBytesSync());
  }

  void createNewPageText(String text) {
    doc.addPage(
      pw.Page(
        build: (pw.Context context) =>
            pw.Center(child: pw.Text(text, style: pw.TextStyle(fontSize: 30))),
      ),
    );
  }

  void createNewPageByte(String text, Uint8List file) {
    final image = PdfImage.file(
      doc.document,
      bytes: file,
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
    //TODO(anyone): chcek if the dirname is safe
    if(!await _requestPermissions()){ print("Permissions error!"); return null;}
    String dirPath = (await _localPath) ;
    new Directory(dirPath).create(recursive: true).then((value) {
      final file = File(dirPath + "/" + dirName + ".pdf");
      print(dirPath + "/" + dirName);
      file.writeAsBytesSync(doc.save());
    });
    return dirPath + "/" + dirName + ".pdf";
  }
}
