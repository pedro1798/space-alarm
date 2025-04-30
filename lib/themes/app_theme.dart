import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'NanumGothic',
      brightness: Brightness.light,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(
          0xFF6200EE,
        ), // Primary color: Purple 500, HEX: #6200EE
        brightness: Brightness.light,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: Color(0xFF000000),
          fontSize: 16,
        ), // Body text: Black color
        bodyMedium: TextStyle(
          color: Color(0xFF333333), // Secondary text: Dark grey color
          fontSize: 14,
        ), // Smaller body text
        headlineLarge: TextStyle(
          color: Color(0xFF6200EE), // Headline: Primary purple color
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ), // Title text
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(
            0xFFFFFFFF,
          ), // Button background: White, HEX: #FFFFFF
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded button corners
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(
          0xFF6200EE,
        ), // AppBar background: Primary purple color
        titleTextStyle: TextStyle(
          color: Colors.white, // AppBar title text: White color
          fontSize: 20,
        ), // AppBar title style
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF6200EE), // Icon color: Primary purple color
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(
          const Color(0xFF6200EE),
        ), // Scrollbar thumb color: Primary purple color
        trackColor: WidgetStateProperty.all(
          Colors.grey.shade300,
        ), // Scrollbar track color: Light grey
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF6200EE),
          ), // Focused input border: Primary purple color
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFCCCCCC),
          ), // Disabled input border: Light grey color
        ),
        hintStyle: TextStyle(
          color: Color(0xFF9E9E9E),
        ), // Hint text: Medium grey color
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: 'NanumGothic',
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(
          0xFFBB86FC,
        ), // Primary color: Purple 200, HEX: #BB86FC
        brightness: Brightness.dark,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 16,
        ), // Body text: White color
        bodyMedium: TextStyle(
          color: Color(0xFFBDBDBD), // Secondary text: Light grey color
          fontSize: 14,
        ), // Smaller body text
        headlineLarge: TextStyle(
          color: Color(0xFFBB86FC), // Headline: Secondary purple color
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ), // Title text
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(
            0xFF121212,
          ), // Button background: Dark grey, HEX: #121212
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded button corners
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(
          0xFF121212,
        ), // AppBar background: Dark grey color
        titleTextStyle: TextStyle(
          color: Colors.white, // AppBar title text: White color
          fontSize: 20,
        ), // AppBar title style
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFFBB86FC), // Icon color: Secondary purple color
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(
          const Color(0xFFBB86FC),
        ), // Scrollbar thumb color: Secondary purple color
        trackColor: WidgetStateProperty.all(
          Colors.grey.shade700,
        ), // Scrollbar track color: Dark grey
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFBB86FC),
          ), // Focused input border: Secondary purple color
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF616161),
          ), // Disabled input border: Medium grey color
        ),
        hintStyle: TextStyle(
          color: Color(0xFF9E9E9E),
        ), // Hint text: Medium grey color
      ),
    );
  }
}
