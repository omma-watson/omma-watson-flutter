import 'package:flutter/material.dart';

const Color _foregroundColor = Color(0xFF155CFF);
Color _backgroundColor = const Color(0xFF91B2FF);

class SafeFoodTag extends StatelessWidget {
  const SafeFoodTag({super.key});

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
        '양호',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: _foregroundColor,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
