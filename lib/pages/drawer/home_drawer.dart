import 'package:flutter/material.dart';
import 'package:plata/controllers/theme_controller.dart';
import 'package:plata/pages/settings_page.dart';
import 'package:plata/pages/geofense_page.dart';
import 'package:get/get.dart';
import 'package:plata/themes/app_theme.dart'; // 테마 사용

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme; // 자주 쓸거니까 꺼내놓음
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Drawer(
      backgroundColor: colorScheme.background, // Drawer 전체 배경도 테마 적용
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: colorScheme.primary, // primary 색상 사용
            ),
            child: Text(
              'home_drawer DrawerHeader',
              style: textTheme.headlineLarge?.copyWith(
                color: colorScheme.onPrimary, // primary 대비 텍스트 색상
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dark_mode, color: colorScheme.secondary),
            title: Text(
              '다크모드',
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onBackground,
              ),
            ),
            onTap: themeController.toggleTheme,
          ),
          ListTile(
            leading: Icon(
              Icons.add_location_alt_outlined,
              color: colorScheme.secondary,
            ),
            title: Text(
              '루틴 등록',
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onBackground,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GeofencePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: colorScheme.secondary),
            title: Text(
              'Settings',
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onBackground,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
