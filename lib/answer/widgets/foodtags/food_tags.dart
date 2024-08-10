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

  static Widget? getFoodTageByBadge(String badge) {
    if (badge == '추천') {
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
