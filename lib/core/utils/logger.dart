import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,   // Number of method calls to be shown
      colors: true,     // Enable colors
      printEmojis: true,// Emojis for log levels
      printTime: true,  // Show time
    ),
  );

  AppLogger(String s);

  // INFO (blue)
  static void info(String message) {
    _logger.i(message);
  }

  // WARNING (yellow)
  static void warn(String message) {
    _logger.w(message);
  }

  // ERROR (red)
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  // DEBUG (cyan)
  static void debug(String message) {
    _logger.d(message);
  }

  // SUCCESS (green) → just use info or create a custom method
  static void success(String message) {
    _logger.i("✅ SUCCESS: $message"); // You can prepend emoji or label
  }
}
