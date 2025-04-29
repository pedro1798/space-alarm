import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'NanumGothic',
      brightness: Brightness.light,
      primaryColor: const Color.fromARGB(255, 189, 199, 208),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 165, 189, 208), // 버튼 색
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ), // 둥근 버튼
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: 'NanumGothic',
      brightness: Brightness.dark,
      primaryColor: const Color.fromARGB(255, 9, 48, 82),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 165, 189, 208), // 버튼 색
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ), // 둥근 버튼
        ),
      ),
    );
  }
}
