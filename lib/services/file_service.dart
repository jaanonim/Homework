import 'dart:convert';
import 'dart:io';

import 'package:homework/models/homework_item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:homework/models/settings_data.dart';

Future<String> get _localPath async {
  final directory = await getExternalStorageDirectory();
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
  try {
    final file = await _localFile;

    String contents = await file.readAsString();

    Map data = jsonDecode(contents);

    return HomeworkItem.fromJSON(data, null);
  } catch (e) {
    print(e);
    return null;
  }
}

Future<File> writeSettings(SettingsData data) async {
  // TODO: remove this todo
  return null;
  final file = await _localFile;

  return file.writeAsString(jsonEncode(data));
}

Future<HomeworkItem> readSettings() async {
  try {
    final file = await _localFile;

    String contents = await file.readAsString();

    Map data = jsonDecode(contents);

    return HomeworkItem.fromJSON(data, null);
  } catch (e) {
    print(e);
    return null;
  }
}
