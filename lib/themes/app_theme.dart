import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'NanumGothic',
      brightness: Brightness.light,
      useMaterial3: true, // Material 3 사용
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 48, 142, 22),
        // 홈페이지 앱바 생상
        brightness: Brightness.light,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 169, 112, 112), // 버튼 색
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ), // 둥근 버튼S
        ),
      ),
      appBarTheme: AppBarTheme(
        // 세팅 앱바 색상
        backgroundColor: const Color.fromARGB(255, 169, 83, 83),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: 'NanumGothic',
      brightness: Brightness.dark,
      useMaterial3: true, // Material 3 사용
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF093052), // primaryColor 역할
        brightness: Brightness.dark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 50, 143, 220), // 버튼 색
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ), // 둥근 버튼
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color.fromARGB(255, 3, 21, 36), // AppBar 색상
      ),
    );
  }
}
