import 'package:flutter/foundation.dart';
import 'package:homework/services/file_service.dart';

class SettingsData with ChangeNotifier{
  bool isActive = false;

  void saveAndRefresh() {
    writeSettings(this);
    notifyListeners();
  }

  void setActive(bool b){
    isActive = b;
    saveAndRefresh();
  }
}