import 'package:flutter/material.dart';

const Color _foregroundColor = Color(0xFF155CFF);
const Color _backgroundColor = Color.fromARGB(255, 223, 232, 255);

class SafeFoodTag extends StatelessWidget {
  const SafeFoodTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _foregroundColor,
          width: 1,
        ),
      ),
      child: Text(
        'Satisfactory',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: _foregroundColor,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
