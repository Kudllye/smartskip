import 'package:flutter/services.dart';

class AccessibilityBridge {
  static const _channel = MethodChannel('smart_skip/accessibility');

  static Future<bool> isAccessibilityEnabled() async {
    try {
      final bool enabled =
          await _channel.invokeMethod('isAccessibilityEnabled');
      return enabled;
    } catch (_) {
      return false;
    }
  }

  static Future<void> openAccessibilitySettings() async {
    try {
      await _channel.invokeMethod('openAccessibilitySettings');
    } catch (_) {}
  }
}
