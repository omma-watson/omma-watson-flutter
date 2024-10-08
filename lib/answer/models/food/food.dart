import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:omma_watson_flutter/answer/models/product/product.dart';

import '../feedback/feedback.dart';

part 'food.freezed.dart';
part 'food.g.dart';

@freezed
class Food with _$Food {
  factory Food({
    required int badge,
    required String content,
    required List<String> solution,
    required Feedback feedback,
    required List<Product> products,
    @JsonKey(name: 'food_name') required String foodName,
    @JsonKey(name: 'detailed_food_name') required String detailedFoodName,
    required String persona,
  }) = _Food;

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
}
