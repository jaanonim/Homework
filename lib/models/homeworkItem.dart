import 'package:uuid/uuid.dart';


class FolderItem extends HomeworkItem{
  List<Uuid> children;

  FolderItem({title}):super(title: title);
}

class FileItem extends HomeworkItem{
  String imgUrl;

  FileItem({title, this.imgUrl}):super(title: title);
}

abstract class HomeworkItem{
  static Uuid uuid = Uuid();
  String id = uuid.v1();
  String title;

  HomeworkItem({this.title});
}