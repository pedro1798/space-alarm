import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:plata/controllers/location_controller.dart';
import 'package:plata/widgets/geofences/geofence_circle.dart';
import 'package:plata/widgets/geofences/geofence_marker.dart';
import 'package:plata/controllers/location_tracker_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plata/models/stored_location.dart';

class FlutterMapWidget extends StatefulWidget {
  final Rx<StoredLocation?>? storedLocation;

  const FlutterMapWidget({super.key, this.storedLocation});

  @override
  State<FlutterMapWidget> createState() => _FlutterMapWidgetState();
}

class _FlutterMapWidgetState extends State<FlutterMapWidget> {
  final MapController mapCtrl = Get.find<MapController>();
  final LocationController locCtrl = Get.find<LocationController>();
  final LocationTrackerController trackerCtrl =
      Get.find<LocationTrackerController>();

  late final Worker? locationWorker;

  @override
  void initState() {
    super.initState();
    // Statefulwidget의 상태 클래스에서 상위 클래스인 State의 initStaete()를 호출하여 초기화하는 코드.
    // 플러터의 생명주기 초기화 보장 위해 필수적으로, 가장 먼저 명시적으로 호출해야한다.

    // 위치 선택 시 맵 이동 처리
    if (widget.storedLocation != null) {
      locationWorker = ever<StoredLocation?>(widget.storedLocation!, (
        location,
      ) {
        if (location != null) {
          mapCtrl.move(LatLng(location.latitude, location.longitude), 17);
        }
      });
    }
    // widget.storedLocation!가 변경되면 다음 매개변수인 콜백 함수 실행

    // 초기 위치 이동
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (locCtrl.locations.isNotEmpty) {
        final firstLoc = locCtrl.locations.first;
        mapCtrl.move(LatLng(firstLoc.latitude, firstLoc.longitude), 17);
      }
    });
  }

  @override
  void dispose() {
    locationWorker?.dispose();
    super.dispose();
  }

  // 현재 위치로 이동
  Future<void> moveToCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

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

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
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
      mapCtrl.move(LatLng(position.latitude, position.longitude), 17);
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
      if (locCtrl.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return Stack(
        children: [
          FlutterMap(
            mapController: mapCtrl,
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
                markers: [
                  ...locCtrl.locations.map(buildGeofenceMarker),
                  if (trackerCtrl.currentPosition.value != null)
                    Marker(
                      point: LatLng(
                        trackerCtrl.currentPosition.value!.latitude,
                        trackerCtrl.currentPosition.value!.longitude,
                      ),
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.person_pin_circle,
                        color: Colors.blue,
                        size: 40,
                      ),
                    ),
                ],
              ),
              PolygonLayer(
                polygons:
                    locCtrl.locations
                        .where(
                          (loc) => loc.alarmEnabled,
                        ) // alarmEnabled가 true인 경우만 필터링
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
              onPressed: () {
                if (trackerCtrl.isTracking.value) {
                  trackerCtrl.stopTracking();
                } else {
                  trackerCtrl.startTracking();
                }
              },
              backgroundColor:
                  trackerCtrl.isTracking.value
                      ? Colors.blue
                      : Theme.of(context).colorScheme.primaryFixed,
              mini: true,
              child: Icon(
                trackerCtrl.isTracking.value
                    ? Icons.location_off
                    : Icons.my_location,
              ),
            ),
          ),
        ],
      );
    });
  }
}
