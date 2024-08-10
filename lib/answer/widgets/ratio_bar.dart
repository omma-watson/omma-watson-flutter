import 'package:flutter/material.dart';

class FeedbackRatioBar extends StatelessWidget {
  const FeedbackRatioBar({
    super.key,
    required this.good,
    required this.bad,
  });

  final int good;
  final int bad;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: good,
          child: Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: good >= bad
                  // ? const Color(0xFF155CFF)
                  ? const Color(0xFF4A81FF)
                  : const Color(0xFF91B2FF),
            ),
            child: good >= bad
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        '찬성 ${(good / (good + bad) * 100).round()}%',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  )
                : null,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          flex: bad,
          child: Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: bad > good
                  // ? const Color(0xFFFF4040)
                  ? const Color(0xFFFF7373)
                  : const Color(0xFFFFD7D7),
            ),
            child: bad > good
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        '반대 ${(bad / (good + bad) * 100).round()}%',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
