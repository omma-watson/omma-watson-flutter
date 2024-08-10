import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home/home_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://omma-watson-api.vercel.app/api',
    contentType: Headers.jsonContentType,
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '엄마 왓슨',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF155CFF),
          primary: const Color(0xFF155CFF),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
