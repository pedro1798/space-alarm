import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:plata/controllers/location_controller.dart';
import 'package:plata/models/stored_location.dart';

Marker buildGeofenceMarker(StoredLocation location) {
  final LocationController locationController =
      Get.find<LocationController>(); // LocationController 찾기

  return Marker(
    point: LatLng(location.latitude, location.longitude),
    width: 100,
    height: 100,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 지오펜스를 삭제하는 아이콘 버튼
        IconButton(
          icon: const Icon(Icons.location_on, color: Colors.red),
          onPressed: () {
            // 지오펜스 삭제 확인 다이얼로그
            Get.defaultDialog(
              title: '지오펜스 삭제',
              middleText: '정말로 삭제하시겠습니까?',
              textConfirm: '삭제',
              textCancel: '취소',
              onConfirm: () {
                locationController.deleteLocation(
                  location.toGeofence(),
                ); // 지오펜스 삭제
                Get.back(); // 다이얼로그 닫기
              },
              onCancel: () {
                Get.back(); // 취소 시 다이얼로그 닫기
              },
            );
          },
        ),
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 2),
            ],
          ),
          child: Text(
            location.name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
