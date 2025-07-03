import 'package:flutter/material.dart';
import 'package:plata/controllers/theme_controller.dart';
import 'package:plata/pages/settings_page.dart';
import 'package:plata/pages/map_page.dart';
import 'package:get/get.dart';
import 'package:plata/utils/navigation_helper.dart' as nh;

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme; // 테마에서 colorScheme 가져오기
    final TextTheme textTheme =
        Theme.of(context).textTheme; // 테마에서 textTheme 가져오기

    return Drawer(
      backgroundColor: colorScheme.surface, // Drawer 배경 색상
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: colorScheme.primary, // primary 색상 사용
            ),
            child: Text(
              "I'll let you know when you arrive.",
              style: textTheme.headlineLarge?.copyWith(
                color: colorScheme.onPrimary, // primary 대비 텍스트 색상
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dark_mode, color: colorScheme.secondary),
            title: Text(
              'Dark Mode',
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface, // 배경에 대비되는 텍스트 색상
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
              'Routine list',
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            onTap: () {
              nh.safeNavigatePush(context: context, page: MapPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: colorScheme.secondary),
            title: Text(
              'Settings',
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            onTap: () {
              nh.safeNavigatePush(context: context, page: SettingPage());
            },
          ),
        ],
      ),
    );
  }
}
