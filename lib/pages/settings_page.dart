import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 클립보드를 위해 필요

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final String email = 'peter584aa@knu.ac.kr';
  final String github = 'https://github.com/pedro1798';

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied: $text'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        // 여기에 적용
        child: ListView(
          children: [
            const SizedBox(height: 20),
            ListTile(
              title: Text(email),
              trailing: IconButton(
                icon: const Icon(Icons.copy),
                tooltip: "Click to copy the text.",
                onPressed: () => _copyToClipboard(email),
              ),
            ),
            ListTile(
              title: Text(github),
              trailing: IconButton(
                icon: const Icon(Icons.copy),
                tooltip: "Click to copy the text.",
                onPressed: () => _copyToClipboard(github),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
