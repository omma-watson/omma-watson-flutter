import 'package:freezed_annotation/freezed_annotation.dart';

part 'popular_question.freezed.dart';
part 'popular_question.g.dart';

@freezed
class PopularQuestion with _$PopularQuestion {
  factory PopularQuestion({
    required String question,
    required int pregnancyWeek,
  }) = _PopularQuestion;

  factory PopularQuestion.fromJson(Map<String, dynamic> json) =>
      _$PopularQuestionFromJson(json);
}
