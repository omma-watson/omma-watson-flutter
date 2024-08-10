import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:omma_watson_flutter/answer/models/price/price.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  factory Product({
    required String title,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'img') required String imgUrl,
    required Price price,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'url') required String productUrl,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
