import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // ThemeController는 GetX의 컨트롤러로, 앱의 테마를 관리합니다.
  // GetX를 사용하여 상태 관리를 간편하게 처리합니다.

  // 현재 테마를 저장하는 변수
  var isDarkMode = false.obs;

  ThemeMode get themeMode =>
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  // 테마를 전환하는 메서드
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }
}
