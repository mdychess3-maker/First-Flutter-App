import 'package:flutter/services.dart';

/// Centralised haptic helpers so every tappable surface in the app feels
/// consistent — the small tactile detail that makes chat apps like
/// WhatsApp feel "alive" rather than static.
class Haptics {
  Haptics._();

  static void tap() => HapticFeedback.lightImpact();
  static void select() => HapticFeedback.selectionClick();
  static void success() => HapticFeedback.mediumImpact();
}
