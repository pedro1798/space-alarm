import 'package:flutter/material.dart';
import 'package:plata/widgets/flutter_map_widget.dart';
import 'package:plata/widgets/location_list_widget.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Space Alarm')),
      body: Center(
        child: Column(
          children: [
            Expanded(flex: 3, child: FlutterMapWidget()),
            // const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            const Text('저장된 위치 목록', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Expanded(flex: 2, child: LocationListWidget()),
          ],
        ),
      ),
    );
  }
}
