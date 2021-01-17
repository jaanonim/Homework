import 'dart:io';
import 'package:homework/models/document_elements/document_element.dart';
import 'package:homework/models/document_elements/image_doc_element.dart';
import 'package:homework/models/document_elements/text_doc_element.dart';
import 'package:homework/models/homework_item.dart';
import 'package:homework/models/pdf_creator.dart';
import 'package:share/share.dart';

class DocumentEditor {
  List<DocumentElement> items = [];
  var title;
  Function saveFunc;

  DocumentEditor(FileItem homework, var saveFunction) {
    items = homework.docElements;
    title = homework.title;
    saveFunc = saveFunction;
  }

  List<DocumentElement> getPages() {
    return items;
  }

  void removePage(DocumentElement i) {
    if (items.contains(i)) items.remove(i);

    saveFunc();
  }

  swapPages(var object, bool isUp) {
    int oldIndex = items.indexOf(object);
    int newIndex = oldIndex + (isUp ? -1 : 1);
    if (newIndex < 0 || newIndex >= items.length) return;
    var temp = items[oldIndex];
    items.removeAt(oldIndex);
    items.insert(newIndex, temp);
    saveFunc();
  }

  addNewImage(ImageDocElement path) {
    items.add(path);
    saveFunc();
  }

  void addNewText(TextDocElement element) {
    items.add(element);
    saveFunc();
  }

  Future<String> generatePDF() async {
    var pdf = new PdfCreator();
    var tempText = "";
    for (var src in items) {
      if (src is TextDocElement) {
        tempText += (src as TextDocElement).text;
        continue;
      }
      var img = src as ImageDocElement;
      pdf.createNewPageSrc(tempText, img.imageSrc);
      tempText = "";
    }

    return await pdf.save(title);
  }

  Future<void> sharePDF() async {
    String path = await generatePDF();

    Share.shareFile(File(path), subject: 'Homework Generator-' + title);
  }
}
