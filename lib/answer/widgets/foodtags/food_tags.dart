import 'package:flutter/material.dart';
import 'package:omma_watson_flutter/answer/widgets/foodtags/danger_food_tag.dart';
import 'package:omma_watson_flutter/answer/widgets/foodtags/recommended_food_tag.dart';
import 'package:omma_watson_flutter/answer/widgets/foodtags/safe_food_tag.dart';
import 'package:omma_watson_flutter/answer/widgets/foodtags/warning_food_tag.dart';

class FoodTags {
  static Widget recommended = const RecommendedFoodTag();
  static Widget safe = const SafeFoodTag();
  static Widget warning = const WarningFoodTag();
  static Widget danger = const DangerFoodTag();

  static Widget? getFoodTageByBadge(int badge) {
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
