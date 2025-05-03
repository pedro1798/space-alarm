import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 62, 151, 186),
      // seedColor만 바꾸면 다른 색상으로 자동 생성됨
      brightness: Brightness.light,
    );

    return ThemeData(
      fontFamily: 'NanumGothic',
      brightness: Brightness.light,
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: colorScheme.onSurface, fontSize: 16),
        bodyMedium: TextStyle(
          color: colorScheme.onSurface.withValues(),
          fontSize: 14,
        ),
        headlineLarge: TextStyle(
          color: colorScheme.primary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        titleTextStyle: TextStyle(color: colorScheme.onPrimary, fontSize: 20),
      ),
      iconTheme: IconThemeData(color: colorScheme.primary),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(colorScheme.primary),
        trackColor: WidgetStateProperty.all(colorScheme.surfaceContainerHigh),
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        hintStyle: TextStyle(color: colorScheme.onSurface.withValues()),
      ),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      // seedColor: const Color(0xFFCCFF90),
      seedColor: const Color.fromARGB(255, 62, 151, 186),
      brightness: Brightness.dark,
    );

    return ThemeData(
      fontFamily: 'NanumGothic',
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: colorScheme.onSurface, fontSize: 16),
        bodyMedium: TextStyle(
          color: colorScheme.onSurface.withValues(),
          fontSize: 14,
        ),
        headlineLarge: TextStyle(
          color: colorScheme.primary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        titleTextStyle: TextStyle(color: colorScheme.onSurface, fontSize: 20),
      ),
      iconTheme: IconThemeData(color: colorScheme.primary),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(colorScheme.primary),
        trackColor: WidgetStateProperty.all(
          colorScheme.surfaceContainerHighest,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        hintStyle: TextStyle(color: colorScheme.onSurface.withValues()),
      ),
    );
  }
}
