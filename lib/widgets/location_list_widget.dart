import 'package:flutter/material.dart';
import 'package:plata/services/location_db.dart';
import 'package:plata/models/stored_location.dart';
import 'package:get/get.dart';
import 'package:plata/controllers/location_controller.dart';

class LocationListWidget extends StatefulWidget {
  const LocationListWidget({super.key});

  @override
  State<LocationListWidget> createState() => _LocationListWidgetState();
}

class _LocationListWidgetState extends State<LocationListWidget> {
  List<StoredLocation> locations = [];
  final LocationController controller = Get.find<LocationController>();

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    final data = await LocationDatabase.getLocations();
    setState(() {
      locations = data;
    });
  }

  Future<void> _deleteLocation(String id) async {
    await LocationDatabase.deleteLocation(id);
    _loadLocations(); // 또는 setState(() => locations.removeWhere((l) => l.id == id));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final locations = controller.locations;
      if (locations.isEmpty) {
        return const Center(child: Text('There are no locations registered.'));
      }

      return ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final loc = locations[index];
          return ListTile(
            leading: const Icon(Icons.location_on),
            title: Text('ID: ${loc.id}'),
            subtitle: Text(
              '위도: ${loc.latitude}, 경도: ${loc.longitude}, 반경: ${loc.radius}m',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => controller.deleteLocation(loc.id),
            ),
          );
        },
      );
    });
  }
}
