import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:plata/controllers/location_controller.dart';
import 'package:plata/widgets/geofences/geofence_circle.dart';
import 'package:plata/widgets/geofences/geofence_marker.dart';

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
                locationController.locations.map(buildGeofenceMarker).toList(),
          ),
          PolygonLayer(
            polygons:
                locationController.locations
                    .map((loc) => GeofenceCircle.fromLocation(loc))
                    .toList(),
          ),
        ],
      );
    });
  }
}
/*

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:plata/controllers/location_controller.dart';
import 'package:plata/widgets/geofences/geofence_circle.dart';
import 'package:plata/widgets/geofences/geofence_marker.dart';
import 'package:geolocator/geolocator.dart';

class FlutterMapWidget extends StatefulWidget {
  const FlutterMapWidget({super.key});

  @override
  State<FlutterMapWidget> createState() => _FlutterMapWidgetState();
}

class _FlutterMapWidgetState extends State<FlutterMapWidget> {
  final MapController mapController = MapController();
  final LocationController locationController = Get.find<LocationController>();

  @override
  void initState() {
    super.initState();

    // 초기 위치 이동
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (locationController.locations.isNotEmpty) {
        final firstLoc = locationController.locations.first;
        mapController.move(LatLng(firstLoc.latitude, firstLoc.longitude), 16.5);
      }
    });
  }

  Future<void> moveToCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("위치 서비스 꺼짐", "설정에서 위치 서비스를 켜주세요");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        Get.snackbar("위치 권한 없음", "앱의 위치 권한을 허용해주세요");
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    mapController.move(LatLng(position.latitude, position.longitude), 17);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (locationController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: LatLng(35.889230, 128.610263), // 경북대
              initialZoom: 16.2,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers:
                    locationController.locations
                        .map(buildGeofenceMarker)
                        .toList(),
              ),
              PolygonLayer(
                polygons:
                    locationController.locations
                        .map((loc) => GeofenceCircle.fromLocation(loc))
                        .toList(),
              ),
            ],
          ),
          Positioned(
            left: 10,
            bottom: 10,
            child: FloatingActionButton(
              heroTag: "btn_my_location",
              onPressed: moveToCurrentLocation,
              mini: true,
              backgroundColor: Colors.blue,
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      );
    });
  }
}
*/