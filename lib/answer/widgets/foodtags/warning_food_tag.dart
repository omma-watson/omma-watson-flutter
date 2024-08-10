import 'package:flutter/material.dart';

const Color _foregroundColor = Color(0xFFF6A000);
const Color _backgroundColor = Color(0xFFFFE5B4);

class WarningFoodTag extends StatelessWidget {
  const WarningFoodTag({super.key});

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
        '주의',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: _foregroundColor,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
