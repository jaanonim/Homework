import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:homework/models/homework_item.dart';
import 'dart:io';

Future<String> get _localPath async {
  final directory = await getExternalStorageDirectory();

  print(directory.path);
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/hierarchy.json');
}

Future<File> writeItem(HomeworkItem item) async {
  final file = await _localFile;

  return file.writeAsString(jsonEncode(item.toJSON()));
}

Future<HomeworkItem> readItem() async {
  //try {
    final file = await _localFile;

    String contents = await file.readAsString();

    Map data = jsonDecode(contents);

    return HomeworkItem.fromJSON(data,null);
  //} catch (e) {
  //  print(e);
  //  return null;
  //}
}