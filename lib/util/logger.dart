import 'package:logger/logger.dart' as pub;

class Logger {
  static final pub.Logger _logger = pub.Logger();

  static i(dynamic data) => _logger.i(data);

  static d(dynamic data) => _logger.d(data);

  static e(String tag, dynamic data) => _logger.e(tag, data);
}
