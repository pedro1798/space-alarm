import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plata/controllers/location_controller.dart';
import 'package:plata/models/stored_location.dart';

class LocationListWidget extends StatelessWidget {
  final void Function(StoredLocation location)? onLocationTap;
  const LocationListWidget({super.key, this.onLocationTap});

  @override
  Widget build(BuildContext context) {
    final LocationController controller = Get.find<LocationController>();

    return Obx(() {
      final storedLocations = controller.locations;

      if (storedLocations.isEmpty) {
        return const Center(
          child: Text('There are no storedLocations registered.'),
        );
      }

      return ListView.builder(
        // 부모 스크롤 위젯에 위임
        itemCount: storedLocations.length,
        itemBuilder: (context, index) {
          final loc = storedLocations[index];
          return ListTile(
            leading: const Icon(Icons.location_on),
            title: Text('Name: ${loc.name}'),
            subtitle: Text(
              'Latitude: ${loc.latitude}, Longitude: ${loc.longitude}, Radius: ${loc.radius}m',
            ),
            onTap: () {
              onLocationTap?.call(loc); // 콜백 호출
            },
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
                    await controller.deleteLocation(loc.toGeofence());
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
