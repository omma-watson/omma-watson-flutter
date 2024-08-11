import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../answer/models/nutrition_fact/nutrition_fact.dart';
import '../api/api.dart';
import '../main.dart';

List<NutritionFact> mockNutritionFact = [
  NutritionFact.fromJson(
    {
      "id": "D303-148450000-0001",
      "metadata": {"식품명": "라면_짬뽕라면", "업체명": "해당없음", "대표식품명": "라면"},
      "nutrition": {
        "인(mg)": "41",
        "철(mg)": "0",
        "당류(g)": "0.21",
        "수분(g)": "80.1",
        "지방(g)": "3.51",
        "회분(g)": "1.25",
        "칼륨(mg)": "88",
        "칼슘(mg)": "78",
        "단백질(g)": "2.84",
        "나트륨(mg)": "333",
        "니아신(mg)": "0.28",
        "티아민(mg)": "0.177",
        "레티놀(μg)": "0",
        "비타민 C(mg)": "0",
        "식이섬유(g)": "1.1",
        "에너지(kcal)": "92",
        "탄수화물(g)": "12.27",
        "포화지방산(g)": "1.15",
        "리보플라빈(mg)": "0.211",
        "콜레스테롤(mg)": "14.23",
        "베타카로틴(μg)": "203",
        "비타민 A(μg RAE)": "17",
        "트랜스지방산(g)": "0.01"
      },
      "totalNutrition": {
        "인(mg)": "307.5",
        "당류(g)": "1.575",
        "수분(g)": "600.7499999999999",
        "지방(g)": "26.325",
        "회분(g)": "9.375",
        "칼륨(mg)": "660",
        "칼슘(mg)": "585",
        "단백질(g)": "21.3",
        "나트륨(mg)": "2497.5",
        "니아신(mg)": "2.1",
        "티아민(mg)": "1.3275",
        "식이섬유(g)": "8.250000000000002",
        "에너지(kcal)": "690",
        "탄수화물(g)": "92.025",
        "포화지방산(g)": "8.624999999999998",
        "리보플라빈(mg)": "1.5825",
        "콜레스테롤(mg)": "106.725",
        "베타카로틴(μg)": "1522.5",
        "비타민 A(μg RAE)": "127.5",
        "트랜스지방산(g)": "0.075"
      },
      "totalStandards": {"영양성분함량기준량": "100", "식품중량": "750"},
      "score": 0.7288866800733395
    },
  ),
];

class NutritionFactScreen extends StatelessWidget {
  NutritionFactScreen({super.key, required this.foodName});

  final String foodName;

  final api = Api(dio);

  Widget _buildNutritionFactTable(NutritionFact nutritionFact) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          const DataColumn(label: Text('Nutrient')),
          DataColumn(
            label: Text(
              'Per ${nutritionFact.totalStandards.standardAmount}g',
            ),
          ),
          DataColumn(
            label: Text(
              'Total(${nutritionFact.totalStandards.foodWeight}g)',
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          foodName,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leadingWidth: 64,
        toolbarHeight: 48,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.chevron_left,
            size: 28,
          ),
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: api.getNutritionFacts(foodName: foodName),
          builder: (context, snapshot) {
            final nutritionFacts = snapshot.data;
            if (nutritionFacts == null) {
              return Skeletonizer(
                child: ListView(
                  children:
                      mockNutritionFact.map(_buildNutritionFactCard).toList(),
                ),
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
