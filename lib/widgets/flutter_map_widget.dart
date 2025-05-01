import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FlutterMapWidget extends StatefulWidget {
  const FlutterMapWidget({super.key});

  @override
  State<FlutterMapWidget> createState() => _FlutterMapWidgetState();
  // StatefulWidget이 처음 빌드될 때 자동으로 호출
}

class _FlutterMapWidgetState extends State<FlutterMapWidget> {
  final MapController mapController = MapController();
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
      ],
    );
  }
}
