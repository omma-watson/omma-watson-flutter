import 'package:freezed_annotation/freezed_annotation.dart';

part 'price.freezed.dart';
part 'price.g.dart';

@freezed
class Price with _$Price {
  factory Price({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'original') required int originalPrice,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'final') required int finalPrice,
  }) = _Price;

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}
