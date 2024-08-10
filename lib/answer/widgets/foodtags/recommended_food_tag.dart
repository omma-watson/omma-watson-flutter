import 'package:flutter/material.dart';

const Color _foregroundColor = Color(0xFF30BB55);
const Color _backgroundColor = Color(0xFFABFFC1);

class RecommendedFoodTag extends StatelessWidget {
  const RecommendedFoodTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _foregroundColor,
          width: 1,
        ),
      ),
      child: Text(
        'Recommend',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: _foregroundColor,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
