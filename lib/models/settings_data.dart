import 'package:flutter/foundation.dart';
import 'package:homework/services/file_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SettingsData with ChangeNotifier {
  SettingsData(bool readFormFile,
      [bool automaticFileName,
      String defaultFileName,
      bool darkTheme,
      bool customMarkup,
      String dateFormat]) {
    if (readFormFile) {
      readSettings().then((data) {
        if (data != null) {
          this._automaticFileName = data._automaticFileName;
          this._defaultFileName = data._defaultFileName;
          this._darkTheme = data._darkTheme;
          this._customMarkup = data._customMarkup;
          this._dateFormat = data._dateFormat;
        } else {
          print("Cannot read file!");
        }
      });
    }

    if (automaticFileName != null) _automaticFileName = automaticFileName;
    if (defaultFileName != null) _defaultFileName = defaultFileName;
    if (darkTheme != null) _darkTheme = darkTheme;
    if (customMarkup != null) _customMarkup = customMarkup;
    if (dateFormat != null) _dateFormat = dateFormat;
  }

  bool _automaticFileName = false;
  bool get automaticFileName => _automaticFileName;
  set automaticFileName(bool automaticFileName) {
    _automaticFileName = automaticFileName;
    saveAndRefresh();
  }

  String _defaultFileName = 'default name';
  String get defaultFileName => _defaultFileName;
  set defaultFileName(String defaultFileName) {
    _defaultFileName = defaultFileName;
    saveAndRefresh();
  }

  bool _darkTheme = true;
  bool get boolTheme => _darkTheme;
  set boolTheme(bool isDark) {
    _darkTheme = isDark;
    saveAndRefresh();
  }

  ThemeMode get theme => _darkTheme ? ThemeMode.dark : ThemeMode.light;
  void switchTheme() {
    _darkTheme = !_darkTheme;
    saveAndRefresh();
  }

  bool _customMarkup = false;
  bool get customMarkup => _customMarkup;
  set customMarkup(bool customMarkup) {
    _customMarkup = customMarkup;
    saveAndRefresh();
  }

  String _dateFormat = 'yyyy-MM-dd';
  String get dateFormat => _dateFormat;
  set dateFormat(String dateFormat) {
    _dateFormat = dateFormat;
    saveAndRefresh();
  }
  DateFormat get getDateFormat => DateFormat(_dateFormat);

  void saveAndRefresh() {
    writeSettings(this);
    notifyListeners();
  }

  Map toJSON() {
    return {
      'automaticFileName': this._automaticFileName,
      'defaultFileName': this._defaultFileName,
      'darkTheme': this._darkTheme,
      'customMarkup': this._customMarkup,
      'dateFormat': this._dateFormat,
    };
  }

  static SettingsData fromJSON(Map map) {
    return SettingsData(false, map['automaticFileName'], map['defaultFileName'],
        map['darkTheme'], map['customMarkup'], map['dateFormat']);
  }
}
