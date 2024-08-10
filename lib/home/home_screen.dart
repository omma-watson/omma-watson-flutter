import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:omma_watson_flutter/answer/answer_screen.dart';
import 'package:omma_watson_flutter/answer/models/question/question.dart';
import 'package:styled_text/styled_text.dart';

import '../answer/answer_screen.dart';
import '../answer/models/question/question.dart';
import '../api/api.dart';
import '../main.dart';
import 'models/popular_question.dart';

const List<String> exampleSearchKeywords = [
  '쫄깃쫄깃 <color>당면</color> 듬뿍 들어간 <color>마라탕</color> 2단계',
  '불어터진 <color>짬뽕</color>',
  '생크림 2번 추가한 <color>케이크</color>',
  '쫄깃쫄깃 <color>당면</color> 듬뿍 들어간 <color>마라탕</color> 2단계',
  '불어터진 <color>짬뽕</color>',
  '생크림 2번 추가한 <color>케이크</color>',
];

List<PopularQuestion> popularQuestions = [
  PopularQuestion(
    question: '쫄깃쫄깃 <color>당면</color> 듬뿍 들어간 <color>마라탕</color> 2단계',
    pregnancyWeek: 15,
  ),
  PopularQuestion(
    question: '불어터진 <color>짬뽕</color>',
    pregnancyWeek: 13,
  ),
  PopularQuestion(
    question: '생크림 2번 추가한 <color>케이크</color>',
    pregnancyWeek: 18,
  ),
  PopularQuestion(
    question: '쫄깃쫄깃 <color>당면</color> 듬뿍 들어간 <color>마라탕</color> 2단계',
    pregnancyWeek: 20,
  ),
  PopularQuestion(
    question: '불어터진 <color>짬뽕</color>',
    pregnancyWeek: 15,
  ),
  PopularQuestion(
    question: '생크림 2번 추가한 <color>케이크</color>',
    pregnancyWeek: 8,
  ),
];

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController queryController = TextEditingController();

  void _onSearchButtonPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => AnswerScreen(
          question: Question.new(query: queryController.text),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                spreadRadius: 100,
                offset: const Offset(0, -100),
              )
            ],
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 8,
                  children: exampleSearchKeywords
                      .map(
                        (keyword) => ActionChip(
                          onPressed: () {},
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          backgroundColor: Colors.white,
                          shape: const StadiumBorder(
                            side: BorderSide(color: Colors.transparent),
                          ),
                          label: StyledText(
                            text: keyword,
                            tags: {
                              'color': StyledTextTag(
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: queryController,
                decoration: InputDecoration(
                  hintText: 'Ask anything about food',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade500,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => _onSearchButtonPressed(context),
                    color: Theme.of(context).colorScheme.primary,
                    icon: const Icon(Icons.search),
                  ),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              const SizedBox(height: 200),
            ],
          ),
        ),
        const SizedBox(height: 40),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Most asked questions',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
            spacing: 12,
            children: popularQuestions
                .map(
                  (question) => Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey.shade200,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StyledText(
                          text: question.question,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          tags: {
                            'color': StyledTextTag(
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          },
                        ),
                        Text(
                          'Pregnancy ${question.pregnancyWeek} weeks',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          // title: Image.asset('assets/logo.png'),
          actions: const [],
        ),
        body: SafeArea(
          child: _buildBody(context),
        ),
      ),
    );
  }
}
