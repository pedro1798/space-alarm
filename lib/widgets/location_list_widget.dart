import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plata/controllers/location_controller.dart';

class LocationListWidget extends StatelessWidget {
  const LocationListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final LocationController controller = Get.find<LocationController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

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
            title: Text('Name: ${loc.name}'),
            subtitle: Text(
              'Latitude: ${loc.latitude}, Longitude: ${loc.longitude}, Radius: ${loc.radius}m',
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
