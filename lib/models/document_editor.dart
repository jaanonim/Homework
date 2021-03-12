import 'package:Homework/models/homework_item.dart';
import 'package:Homework/models/pdf_creator.dart';
import 'package:share/share.dart';

import 'document_elements/document_element.dart';
import 'document_elements/image_doc_element.dart';
import 'document_elements/text_doc_element.dart';

class DocumentEditor {
  List<DocumentElement> items = [];
  var title;
  HomeworkItem homework;
  Function saveFunc;

  DocumentEditor(FileItem homework, var saveFunction) {
    this.homework = homework;
    items = homework.docElements;
    title = homework.title;
    saveFunc = saveFunction;
  }

  void rename(String title){
    homework.title=title;
    saveFunc();
  }

  List<DocumentElement> getPages() {
    return items;
  }

  void removePage(DocumentElement i) {
    if (items.contains(i)){i.remove(); items.remove(i);};

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

  Future<PdfCreator> generatePDF() async {
    var pdf = new PdfCreator();
    var tempText = "";
    for (var src in items) {
      if (src is TextDocElement) {
        tempText += src.text;
        continue;
      }
      var img = src as ImageDocElement;
      pdf.createNewPageSrc(tempText, img);
      tempText = "";
    }
    if (tempText != "") {
      pdf.createNewPageText(tempText);
    }
    return pdf;
  }

  Future<String> savePDF(bool openFile) async {
    var pdf = await generatePDF();
    String path = await pdf.save(title);
    //if(openFile) OpenFile.open(path);
    return path;
  }


  Future<void> sharePDF() async {
    String path = await savePDF(false);
    Share.shareFiles([path], subject: 'Homework Generator-' + title);
  }
}
