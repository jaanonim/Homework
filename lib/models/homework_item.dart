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

  deleteItem() {
    this.parent.children.remove(this);
    if (this.children.isNotEmpty) {
      this.children.forEach((child) {
        child.deleteItem();
      });
    }
  }
}

class FileItem extends HomeworkItem {
  List<String> pathImages;

  FileItem({title}) : super(title: title) {
    pathImages = new List<String>();
  }
}

abstract class HomeworkItem {
  String title;
  FolderItem parent;

  HomeworkItem({this.title});

  deleteItem() {
    parent.children.remove(this);
  }
}
