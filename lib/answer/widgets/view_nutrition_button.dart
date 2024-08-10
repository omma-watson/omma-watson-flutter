import 'package:flutter/material.dart';

class ViewNutritionButton extends StatelessWidget {
  const ViewNutritionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFE4ECF1),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('영양소 함량 보기'),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
          ),
        ],
      ),
    );
  }
}
