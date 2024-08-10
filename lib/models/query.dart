import 'package:freezed_annotation/freezed_annotation.dart';

part 'query.freezed.dart';
part 'query.g.dart';

@freezed
class Query with _$Query {
  factory Query({
    required String query,
  }) = _Query;

  factory Query.fromJson(Map<String, dynamic> json) => _$QueryFromJson(json);
}
