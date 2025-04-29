import 'package:flutter/material.dart';
import 'package:plata/controllers/theme_controller.dart';
import 'package:plata/pages/settings_page.dart';
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
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('home_drawer DrawerHeader'), // Drawer Header
          ),
          ListTile(
            // 다크모드
            title: FloatingActionButton(
              onPressed: themeController.toggleTheme,
              shape: CircleBorder(),
              child: const Icon(Icons.dark_mode),
            ),
          ),
          ListTile(
            title: const Text('루틴 등록'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
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
