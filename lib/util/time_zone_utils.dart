import 'dart:async';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class TimeZoneUtils {
  static bool _isInitialized = false;
  static List<String>? _timeZoneLocations;
  static Completer<void>? _initializationCompleter;

  static Future<void> initialize() async {
    if (!_isInitialized) {
      _initializationCompleter ??= Completer<void>();
      tz.initializeTimeZones();
      _timeZoneLocations = tz.timeZoneDatabase.locations.keys.toList();
      _isInitialized = true;
      _initializationCompleter!.complete();
    }
  }

  static List<String> getTimeZoneLocations() {
    if (_timeZoneLocations == null) {
      throw Exception("TimeZoneUtils is not initialized.");
    }
    return _timeZoneLocations!;
  }

  static tz.TZDateTime getCurrentTime(String locationName) {
    if (!_isInitialized) {
      throw Exception("TimeZoneUtils is not initialized.");
    }
    var location = tz.getLocation(locationName);
    return tz.TZDateTime.now(location);
  }

  static Future<void> waitForInitialization() {
    return _initializationCompleter?.future ?? Future.value();
  }
}
