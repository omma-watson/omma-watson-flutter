import 'package:flutter/material.dart';

import '../answer/models/nutrition_fact/nutrition_fact.dart';
import '../api/api.dart';
import '../main.dart';

class NutritionFactScreen extends StatelessWidget {
  NutritionFactScreen({super.key, required this.foodName});

  final String foodName;

  final api = Api(dio);

  Widget _buildNutritionFactTable(NutritionFact nutritionFact) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          const DataColumn(label: Text('영양성분')),
          DataColumn(
            label: Text(
              '${nutritionFact.totalStandards.standardAmount}g 당 함량',
            ),
          ),
          DataColumn(
            label: Text(
              '총 내용량(${nutritionFact.totalStandards.foodWeight}g)당',
            ),
          ),
        ],
        rows: nutritionFact.nutrition.keys
            .map(
              (key) => DataRow(
                cells: [
                  DataCell(Text(key)),
                  DataCell(
                    Text(
                      double.tryParse(nutritionFact.nutrition[key] ?? '')
                              ?.toStringAsFixed(1) ??
                          '',
                    ),
                  ),
                  DataCell(
                    Text(
                      double.tryParse(nutritionFact.totalNutrition[key] ?? '')
                              ?.toStringAsFixed(1) ??
                          '',
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildNutritionFactCard(NutritionFact nutritionFact) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              nutritionFact.metadata.foodName.replaceFirst(RegExp(r'^.+_'), ''),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (!nutritionFact.metadata.companyName.contains('없음'))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                nutritionFact.metadata.companyName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          _buildNutritionFactTable(nutritionFact),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(foodName),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: api.getNutritionFacts(foodName: foodName),
          builder: (context, snapshot) {
            final nutritionFacts = snapshot.data;
            if (nutritionFacts == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: nutritionFacts.map(_buildNutritionFactCard).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
