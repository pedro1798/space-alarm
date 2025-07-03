import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plata/models/stored_location.dart';
import 'package:plata/widgets/flutter_map_widget.dart';
import 'package:plata/widgets/location_list_widget.dart';

class MapPage extends StatelessWidget {
  final Rx<StoredLocation?> selectedLocation = Rx<StoredLocation?>(null);

  MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Space Alarm')),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: FlutterMapWidget(storedLocation: selectedLocation),
            ),
            const Divider(),
            const SizedBox(height: 8),
            const Text('저장된 위치 목록', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Expanded(
              flex: 2,
              child: LocationListWidget(
                onLocationTap: (location) {
                  selectedLocation.value = location;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
