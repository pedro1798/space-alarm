import 'package:flutter/material.dart';
import 'pages/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Space Alarm',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        fontFamily: 'NanumGothic',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // 버튼 색
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ), // 둥근 버튼
          ),
        ),
      ),
      home: const MyHomePage(title: 'Space Alarm'),
    );
  }
}

// 커밋 테스트
