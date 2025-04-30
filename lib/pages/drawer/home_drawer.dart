import 'package:flutter/material.dart';
import 'package:plata/controllers/theme_controller.dart';
import 'package:plata/pages/settings_page.dart';
import 'package:plata/pages/geofense_page.dart';
import 'package:get/get.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 137, 167, 193),
            ),
            child: Text('home_drawer DrawerHeader'), // Drawer Header
          ),
          ListTile(
            // 다크모드
            leading: const Icon(Icons.dark_mode),
            title: const Text('다크모드'),
            onTap: themeController.toggleTheme,
          ),
          ListTile(
            title: const Text('루틴 등록'),
            onTap: () {
              Navigator.push(
                // Navigate to the settings page
                context,
                MaterialPageRoute(builder: (context) => GeofencePage()),
              );
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                // Navigate to the settings page
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
