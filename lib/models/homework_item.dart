import 'document_elements/document_element.dart';

class FolderItem extends HomeworkItem {
  List<HomeworkItem> children = List();

  FolderItem({title}) : super(title: title);

  moveToFolder(List<HomeworkItem> items) {
    items.forEach((item) {
      if (item.parent != null) {
        item.parent.children.remove(item);
      }
      item.parent = this;
      this.children.add(item);
    });
  }

  FolderItem haveChild(HomeworkItem item) {
    children.forEach((element) {
      if (element == item) {
        return this;
      } else if (element is FolderItem) {
        var b = element.haveChild(item);
        if (b != null) {
          return b;
        }
      }
    });
    return null;
  }

  @override
  Map toJSON() {
    Map m = super.toJSON();
    m.addAll({
      'children': [
        for (int i = 0; i < children.length; i++) children[i].toJSON()
      ]
    });
    return m;
  }
}

class FileItem extends HomeworkItem {
  List<DocumentElement> docElements;

  FileItem({title}) : super(title: title) {
    docElements = new List<DocumentElement>();
  }

  @override
  Map toJSON() {
    Map m = super.toJSON();
    m.addAll({'docElements': [for(var element in docElements) element.toJSON()]});
    return m;
  }

  @override
  deleteItem() {
    docElements.forEach((element) {
      element.remove();
    });
    super.deleteItem();
  }
}

abstract class HomeworkItem {
  String title;
  FolderItem parent;

  HomeworkItem({this.title});

  deleteItem() {
    parent.children.remove(this);
  }

  static HomeworkItem fromJSON(Map map, FolderItem parent) {
    if (map.containsKey('children')) {
      FolderItem item = FolderItem(title: map['title']);
      item.parent = parent;

      Iterable i = map['children'];
      List<Map> children = List<Map>.from(i).map((model) => model).toList();
      item.children = [
        for (int i = 0; i < children.length; i++)
          HomeworkItem.fromJSON(children[i], item)
      ];
      return item;
    } else {
      FileItem item = FileItem(title: map['title']);
      item.parent = parent;
      Iterable i = map['docElements'];
      List<Map> list = List<Map>.from(i).map((model) => model).toList();
      item.docElements = [for(var l in list) DocumentElement.fromJSON(l)];
      return item;
    }
  }

  Map toJSON() {
    return {
      'title': this.title,
    };
  }
}
