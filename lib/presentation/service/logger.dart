import 'dart:convert';

import 'package:logger/logger.dart';

/// Alternative of [print]
class SbLog extends Logger {
  static final _singleton = SbLog._();
  factory SbLog() => _singleton;
  SbLog._() : super(printer: _QtLogPrinter());
}

class _QtLogPrinter extends LogPrinter {
  static const Map<Level, String> _levelEmojis = {
    // ignore: deprecated_member_use
    Level.verbose: '🌸  VERBOSE — ',
    Level.debug: '🐛  DEBUG   — ',
    Level.info: '💡  INFO    — ',
    Level.warning: '👊🏻  WARNING — ',
    Level.error: '⛔  ERROR   — ',
    // ignore: deprecated_member_use
    Level.wtf: '👾  WTF     — ',
    Level.all: '🌈  ALL     — ',
    Level.fatal: '💀  FATAL   — ',
    Level.off: '🔕  OFF     — ',
    Level.trace: '🔍  TRACE   — ',
  };

  String stringifyMessage(dynamic message) {
    if (message is Map || message is Iterable) {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(message);
    } else {
      return message.toString();
    }
  }

  @override
  List<String> log(LogEvent event) {
    final List<String> buffer = [];
    buffer.add(_levelEmojis[event.level]! + stringifyMessage(event.message));
    if (event.error != null) buffer.add(event.error.toString());
    if (event.stackTrace != null) buffer.add(event.stackTrace.toString());
    // FirebaseCrashlytics.instance.log(buffer.join('\n'));
    buffer.add('—————————————————————————————————————————————————————————');
    return buffer;
  }
}

// Ideas
// 📕: error message
// 📙: warning message
// 📗: ok status message
// 📘: action message
// 📓: canceled status message
// 📔: Or anything you like and want to recognize immediately by color