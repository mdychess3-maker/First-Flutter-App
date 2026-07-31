import 'package:flutter/material.dart';

/// Brand palette extracted from the MDY Chess website: obsidian black
/// paired with a warm gold accent, used consistently across both themes.
class AppColors {
  AppColors._();

  static const Color gold = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFEED68A);
  static const Color goldGlow = Color(0x66D4AF37);

  // Dark theme surfaces
  static const Color obsidian = Color(0xFF080808);
  static const Color obsidianElevated = Color(0xFF141414);
  static const Color obsidianCard = Color(0xFF1B1B1B);
  static const Color darkTextDim = Color(0xFFA0A0A0);

  // Light theme surfaces
  static const Color ivory = Color(0xFFFAF7F0);
  static const Color ivoryElevated = Color(0xFFFFFFFF);
  static const Color ivoryCard = Color(0xFFF1ECDF);
  static const Color lightTextDim = Color(0xFF6B6255);
  static const Color lightInk = Color(0xFF1A1712);

  static const Color success = Color(0xFF4CAF50);
  static const Color discordBlurple = Color(0xFF5865F2);

  static const LinearGradient goldTextGradientDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.white, gold],
  );

  static const LinearGradient goldTextGradientLight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [lightInk, gold],
  );
}
