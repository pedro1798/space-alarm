import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:plata/controllers/location_controller.dart';
import 'package:plata/widgets/geofences/geofence_circle.dart';
import 'package:plata/widgets/geofences/geofence_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plata/models/stored_location.dart';

class FlutterMapWidget extends StatefulWidget {
  final Rx<StoredLocation?>? selectedLocation;

  const FlutterMapWidget({super.key, this.selectedLocation});

  @override
  State<FlutterMapWidget> createState() => _FlutterMapWidgetState();
}

class _FlutterMapWidgetState extends State<FlutterMapWidget> {
  final MapController mapController = Get.find<MapController>();
  final LocationController locationController = Get.find<LocationController>();

  late final Worker? locationWorker;

  @override
  void initState() {
    super.initState();

    // 위치 선택 시 맵 이동 처리
    if (widget.selectedLocation != null) {
      locationWorker = ever<StoredLocation?>(widget.selectedLocation!, (
        location,
      ) {
        if (location != null) {
          mapController.move(LatLng(location.latitude, location.longitude), 17);
        }
      });
    }

    // 초기 위치 이동
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (locationController.locations.isNotEmpty) {
        final firstLoc = locationController.locations.first;
        mapController.move(LatLng(firstLoc.latitude, firstLoc.longitude), 17);
      }
    });
  }

  @override
  void dispose() {
    locationWorker?.dispose();
    super.dispose();
  }

  Future<void> moveToCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
        "위치 서비스 꺼짐",
        "설정에서 위치 서비스를 켜주세요",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "위치 권한 없음",
        "앱의 위치 권한을 허용해주세요",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
      return;
    }

    // 현재 위치로 이동
    try {
      Position position = await Geolocator.getCurrentPosition();
      mapController.move(LatLng(position.latitude, position.longitude), 17);
    } catch (e) {
      Get.snackbar(
        "위치 오류",
        "현재 위치를 가져오는 데 실패했습니다: $e",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
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
              initialCenter: LatLng(35.889230, 128.610263),
              initialZoom: 17,
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
