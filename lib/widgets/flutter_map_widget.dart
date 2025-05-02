import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:plata/controllers/location_controller.dart';
import 'package:plata/utils/geo.helper.dart';

class FlutterMapWidget extends StatefulWidget {
  const FlutterMapWidget({super.key});

  @override
  State<FlutterMapWidget> createState() => _FlutterMapWidgetState();
}

class _FlutterMapWidgetState extends State<FlutterMapWidget> {
  final MapController mapController = MapController();
  final LocationController locationController = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (locationController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: LatLng(35.889230, 128.610263), // 초기 위치: 경북대학교
          initialZoom: 16.2,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers:
                locationController.locations.map((loc) {
                  return Marker(
                    point: LatLng(loc.latitude, loc.longitude),
                    width: 80,
                    height: 80,
                    child: IconButton(
                      icon: const Icon(Icons.location_on, color: Colors.red),
                      onPressed: () {
                        Get.defaultDialog(
                          title: '지오펜스 삭제',
                          middleText: '정말로 삭제하시겠습니까?',
                          textConfirm: '삭제',
                          textCancel: '취소',
                          onConfirm: () {
                            locationController.deleteLocation(loc.id);
                            Get.back();
                          },
                        );
                      },
                    ),
                  );
                }).toList(),
          ),
          PolygonLayer(
            polygons:
                locationController.locations.map((loc) {
                  return Polygon(
                    points: createCirclePoints(
                      LatLng(loc.latitude, loc.longitude),
                      loc.radius,
                      64,
                    ),
                    color: Colors.transparent,
                    borderColor: Colors.blue,
                    borderStrokeWidth: 2,
                  );
                }).toList(),
          ),
        ],
      );
    });
  }
}
