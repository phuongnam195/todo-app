import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class Setting {
  static final Setting _singleton = Setting._internal();
  factory Setting() {
    return _singleton;
  }
  Setting._internal();

  Future<void> init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    _box = await Hive.openBox('Setting');
  }

  static Box? _box;
  static const _languageField = 'Language';
  static const _notificationField = 'Notification';

  String getLanguage() {
    String? languageCode = _box!.get(_languageField);
    if (languageCode == null) {
      languageCode = 'vi';
      setLanguage(languageCode);
    }
    return languageCode;
  }

  bool getNotification() {
    return _box!.get(_notificationField, defaultValue: false);
  }

  setLanguage(String language) {
    _box!.put(_languageField, language);
  }

  setNotification(bool notification) {
    _box!.put(_notificationField, notification);
  }
}
