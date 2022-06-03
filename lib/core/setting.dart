import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/generated/l10n.dart';

class Setting {
  static final Setting _singleton = Setting._internal();
  factory Setting() {
    return _singleton;
  }
  Setting._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final languageCode = getLanguage();
    S.load(Locale(languageCode));
  }

  static const _language = 'Language';
  static const _notification = 'Notification';

  late SharedPreferences _prefs;

  String getLanguage() {
    var languageCode = _prefs.getString(_language);
    if (languageCode == null) {
      languageCode = 'vi';
      setLanguage(languageCode);
    }
    return languageCode;
  }

  bool getNotification() {
    return _prefs.getBool(_notification) ?? false;
  }

  setLanguage(String language) {
    _prefs.setString(_language, language);
  }

  setNotification(bool notification) {
    _prefs.setBool(_notification, notification);
  }
}
