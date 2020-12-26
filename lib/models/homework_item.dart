class FolderItem extends HomeworkItem {
  List<HomeworkItem> children = List();

  FolderItem({title}) : super(title: title);

  MoveToFolder(List<HomeworkItem> items) {
    items.forEach((item) {
      if (item.parent != null) {
        item.parent.children.remove(item);
      }
      item.parent = this;
      this.children.add(item);
    });
  }

  DeleteItem() {
    this.parent.children.remove(this);
    if (this.children.isNotEmpty) {
      this.children.forEach((child) {
        child.DeleteItem();
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

  DeleteItem() {
    parent.children.remove(this);
  }
}
