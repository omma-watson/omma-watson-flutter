import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../answer/models/food/food.dart';
import '../answer/models/nutrition_fact/nutrition_fact.dart';
import '../answer/models/question/question.dart';

part 'api.g.dart';

@RestApi()
abstract class Api {
  factory Api(Dio dio) = _Api;

  @POST('/question/new')
  Future<Food> createNewQuestion(@Body() Question question);

  @GET('/nutrition-facts/{food_name}')
  Future<List<NutritionFact>> getNutritionFacts({
    @Path('food_name') required String foodName,
    @Query('result_count') int? resultCount,
  });
}
