import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plata/controllers/location_controller.dart';

class LocationListWidget extends StatelessWidget {
  const LocationListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final LocationController controller = Get.find<LocationController>();

    return Obx(() {
      final locations = controller.locations;

      if (locations.isEmpty) {
        return const Center(child: Text('There are no locations registered.'));
      }

      return ListView.builder(
        // 부모 스크롤 위젯에 위임
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
              onPressed: () {
                Get.defaultDialog(
                  title: "Delete Location",
                  middleText: "Are you sure you want to delete this location?",
                  textCancel: "Cancel",
                  textConfirm: "Delete",
                  confirmTextColor: Colors.white,
                  onConfirm: () async {
                    await controller.deleteLocation(loc.id);
                    Get.close(1); // 다이얼로그를 닫고 1개 스택을 제거
                  },
                );
              },
            ),
          );
        },
      );
    });
  }
}
