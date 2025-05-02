import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:plata/controllers/location_controller.dart';

class FlutterMapWidget extends StatefulWidget {
  const FlutterMapWidget({super.key});

  @override
  State<FlutterMapWidget> createState() => _FlutterMapWidgetState();
  // StatefulWidget이 처음 빌드될 때 자동으로 호출
}

class _FlutterMapWidgetState extends State<FlutterMapWidget> {
  final MapController mapController = MapController();
  final LocationController locationController = Get.find<LocationController>();
  // MapController는 FlutterMap의 상태를 관리하는 컨트롤러입니다.
  // MapController를 사용하면 지도 중심 좌표, 줌 레벨 등을 제어할 수 있습니다.

  @override
  initState() {
    super.initState();
  }

  /* @override
  void dispose() {
    super.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(35.889230, 128.610263), // 경북대학교 좌표
        initialZoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(35.889230, 128.610263),
              width: 80,
              height: 80,
              child: Icon(Icons.location_pin, color: Colors.red, size: 40),
            ),
          ],
        ),
      ],
    );
  }
}
