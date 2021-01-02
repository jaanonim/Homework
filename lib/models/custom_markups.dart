import 'package:homework/models/settings_data.dart';

String useMarkups(String string, SettingsData data){
  return string.replaceAll(RegExp(r'##date##'), data.getDateFormat.format(DateTime.now()));
}