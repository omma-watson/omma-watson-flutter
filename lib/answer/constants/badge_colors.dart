import 'package:flutter/material.dart';

class BadgeColors {
  static Color recommended = const Color(0xFF30BB55);
  static Color safe = const Color(0xFF155CFF);
  static Color warning = const Color(0xFFF6A000);
  static Color danger = const Color(0xFFFF4040);

  static Color? getColorByBadge(int badge) {
    if (badge == 0) {
      return recommended;
    } else if (badge == 1) {
      return safe;
    } else if (badge == 2) {
      return warning;
    } else if (badge == 3) {
      return danger;
    }
    return null;
  }
}
