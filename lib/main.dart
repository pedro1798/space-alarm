import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plata/controllers/theme_controller.dart';
import 'pages/home/home_page.dart';
import 'themes/app_theme.dart';
import 'package:flutter_map/flutter_map.dart';
import 'handlers/location_permission_hander.dart';
import 'package:plata/controllers/location_controller.dart';
import 'handlers/geofence_register.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController()); // ThemeController 의존성 주입
    Get.put(LocationController()); // LocationController 의존성 주입
    Get.put(MapController());
  }
}

void main() async {
  // Before accesing any methods ensure you initialize the plugin:
  WidgetsFlutterBinding.ensureInitialized();
  await requestLocationPermissions(); // 먼저 위치 권한 요청
  await initGeofenceSystem();
  runApp(GetMaterialApp(initialBinding: InitialBinding(), home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ThemeController를 Get으로 찾기
    final themeController = Get.find<ThemeController>();
    return Obx(
      () => GetMaterialApp(
        title: 'Space Alarm',
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        themeMode: themeController.themeMode, // 동적 적용!
        home: const MyHomePage(title: 'Space Alarm'),
        // home: GeofencePage(),
      ),
    );
  }
}
