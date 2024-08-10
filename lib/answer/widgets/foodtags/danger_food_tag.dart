import 'package:flutter/material.dart';

const Color _foregroundColor = Color(0xFFFF4040);
const Color _backgroundColor = Color(0xFFFFD7D7);

class DangerFoodTag extends StatelessWidget {
  const DangerFoodTag({super.key});

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
        '위험',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: _foregroundColor,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
