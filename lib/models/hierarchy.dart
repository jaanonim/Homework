import 'package:flutter/foundation.dart';
import 'package:Homework/models/homework_item.dart';
import 'package:Homework/models/settings_data.dart';
import 'package:Homework/services/file_service.dart';

class Hierarchy with ChangeNotifier {
  List<FolderItem> hierarchy = [FolderItem(title: "home")];

  FolderItem get home => hierarchy.first;

  FolderItem get now => hierarchy.last;

  bool get isHome => now == home;

  Hierarchy() {
    readItem().then((h) {
      if (h != null) {
        hierarchy.first = h;
        notifyListeners();
      } else {
        print("Cannot read file!");
      }
    });
  }

  void updateHierarchy(Function function) {
    function();
    notifyListeners();
  }

  void saveAndRefresh() {
    writeItem(this.home);
    notifyListeners();
  }

  void removeFromHierarchy(FolderItem folder) {
    for (int i = hierarchy.length - 1; i > 0; i--) {
      if (hierarchy[i] == folder) {
        break;
      }
      hierarchy.removeAt(i);
    }
    notifyListeners();
  }

  void addToHierarchy(FolderItem folder) {
    hierarchy.add(folder);
    notifyListeners();
  }

  HomeworkItem createFile(String title, SettingsData data) {
    HomeworkItem homeworkItem = data.enabledDefaultFile ? HomeworkItem.fromJSON(data.defaultFile.toJSON(),null) :  FileItem();
    homeworkItem.title = title;
    hierarchy.last.moveToFolder([homeworkItem]);
    saveAndRefresh();
    return homeworkItem;
  }

  void createFolder(String title, List<HomeworkItem> items) {
    FolderItem newFolder = FolderItem(title: title);
    hierarchy.last.moveToFolder([
      newFolder,
    ]);
    newFolder.moveToFolder(items);
    saveAndRefresh();
  }

  void moveToFolder(FolderItem folder, HomeworkItem item) {
    folder.moveToFolder([item]);
    saveAndRefresh();
  }

  void renameItem(HomeworkItem item, String title) {
    item.title = title;
    saveAndRefresh();
  }

  void deleteItem(HomeworkItem item) {
    item.deleteItem();
    saveAndRefresh();
  }
}
