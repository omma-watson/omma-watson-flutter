import 'package:flutter/material.dart';

class BadgeColors {
  static Color recommended = const Color(0xFF30BB55);
  static Color safe = const Color(0xFF155CFF);
  static Color warning = const Color(0xFFF6A000);
  static Color danger = const Color(0xFFFF4040);

  static Color? getColorByBadge(String badge) {
    if (badge == '추천' || badge == 'recommended') {
      return recommended;
    } else if (badge == '양호') {
      return safe;
    } else if (badge == '주의') {
      return warning;
    } else if (badge == '위험') {
      return danger;
    }
    return null;
  }
}
