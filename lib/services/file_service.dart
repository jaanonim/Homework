import 'dart:convert';
import 'dart:io';

import 'package:homework/models/homework_item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:homework/models/settings_data.dart';

Future<String> get _localPath async {
  final directory = await getExternalStorageDirectory();
  return directory.path;
}

Future<File> get _localFileHomeworkItem async {
  final path = await _localPath;
  return File('$path/hierarchy.json');
}

Future<File> get _localFileSettingsData async {
  final path = await _localPath;
  return File('$path/settings.json');
}


Future<File> writeItem(HomeworkItem item) async {
  final file = await _localFileHomeworkItem;

  return file.writeAsString(jsonEncode(item.toJSON()));
}

Future<HomeworkItem> readItem() async {
  try {
    final file = await _localFileHomeworkItem;

    String contents = await file.readAsString();
    Map data = jsonDecode(contents);

    return HomeworkItem.fromJSON(data, null);
  } catch (e) {
    print(e);
    return null;
  }
}

Future<File> writeSettings(SettingsData data) async {
  final file = await _localFileSettingsData;

  return file.writeAsString(jsonEncode(data.toJSON()));
}

Future<SettingsData> readSettings() async {
  try {
    final file = await _localFileSettingsData;

    String contents = await file.readAsString();

    Map data = jsonDecode(contents);

    return SettingsData.fromJSON(data);
  } catch (e) {
    print(e);
    return null;
  }
}
