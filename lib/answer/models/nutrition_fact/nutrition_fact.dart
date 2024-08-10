import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition_fact.freezed.dart';
part 'nutrition_fact.g.dart';

@freezed
class NutritionFact with _$NutritionFact {
  factory NutritionFact({
    required String id,
    required NutritionFactMetadata metadata,
    required Map<String, String> nutrition,
    required Map<String, String> totalNutrition,
    required NutritionFactTotalStandards totalStandards,
    required double score,
  }) = _NutritionFact;

  factory NutritionFact.fromJson(Map<String, dynamic> json) =>
      _$NutritionFactFromJson(json);
}

@freezed
class NutritionFactMetadata with _$NutritionFactMetadata {
  factory NutritionFactMetadata({
    @JsonKey(name: '식품명') required String foodName,
    @JsonKey(name: '업체명') required String companyName,
    @JsonKey(name: '대표식품명') required String representativeFoodName,
  }) = _NutritionFactMetadata;

  factory NutritionFactMetadata.fromJson(Map<String, dynamic> json) =>
      _$NutritionFactMetadataFromJson(json);
}

@freezed
class NutritionFactTotalStandards with _$NutritionFactTotalStandards {
  factory NutritionFactTotalStandards({
    @JsonKey(name: '영양성분함량기준량') required String standardAmount,
    @JsonKey(name: '식품중량') required String foodWeight,
  }) = _NutritionFactTotalStandards;

  factory NutritionFactTotalStandards.fromJson(Map<String, dynamic> json) =>
      _$NutritionFactTotalStandardsFromJson(json);
}
