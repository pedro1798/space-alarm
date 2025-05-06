import 'package:native_geofence/native_geofence.dart' as geo;
import 'package:plata/models/stored_location.dart';
import 'package:get/get.dart';
import 'package:plata/controllers/location_controller.dart';

// 앱 실행 시 OS에 등록된 지오펜스를 초기화하는 함수
Future<void> initGeofenceSystem() async {
  // 1. Native Geofence 초기화
  await geo.NativeGeofenceManager.instance.initialize();

  // 2. OS에 등록된 모든 지오펜스 제거
  try {
    await geo.NativeGeofenceManager.instance.removeAllGeofences();
  } catch (e) {
    print("지오펜스 초기화 실패: $e");
  }

  // 3. DB에서 저장된 지오펜스를 다시 등록
  final locCtrl = Get.find<LocationController>();
  final storedLocations = await locCtrl.getLocations();

  for (final loc in storedLocations) {
    try {
      final geofence = loc.toGeofence();
      await geo.NativeGeofenceManager.instance.createGeofence(
        geofence,
        _geofenceCallback, // 콜백은 기존 함수 사용
      );
    } catch (e) {
      Get.snackbar(
        "등록 실패",
        "지오펜스 등록 실패: ${loc.id}, 오류: $e",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    }
  }
}

// 초기화 (앱 시작 시 한 번만 호출)
Future<void> initializeGeofence() async {
  await geo.NativeGeofenceManager.instance.initialize();
}

/// 콜백 정의
Future<void> _geofenceCallback(geo.GeofenceCallbackParams params) async {
  final event = params.event;
  final geo.Location? location = params.location;

  if (location == null) return;

  Get.snackbar(
    '지오펜스 이벤트 발생',
    '$event @ ${location.latitude}, ${location.longitude}',
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 2),
  );
}

Future<void> registerGeofence({
  required String name,
  required String lat,
  required String long,
  required String rad,
}) async {
  final LocationController locCtrl = Get.find<LocationController>();
  final double? latitude = double.tryParse(lat);
  final double? longitude = double.tryParse(long);
  final double? radiusValue = double.tryParse(rad);

  // Null 또는 유효성 검사
  if (latitude == null || longitude == null || radiusValue == null) {
    Get.snackbar(
      '잘못된 입력',
      '입력란에 공백이 있거나 숫자가 아닙니다.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
    return;
  }

  if (latitude < -90 || latitude > 90 || longitude < -180 || longitude > 180) {
    Get.snackbar(
      '잘못된 입력',
      '유효하지 않은 위도/경도입니다.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
    return;
  }

  final geo.Location userLocation = geo.Location(
    latitude: latitude,
    longitude: longitude,
  );

  final geofenceId = 'geofence_${DateTime.now().millisecondsSinceEpoch}';

  final geofence = geo.Geofence(
    id: geofenceId,
    location: userLocation,
    radiusMeters: radiusValue,
    triggers: {geo.GeofenceEvent.enter, geo.GeofenceEvent.exit},
    iosSettings: geo.IosGeofenceSettings(initialTrigger: true),
    androidSettings: geo.AndroidGeofenceSettings(
      initialTriggers: {geo.GeofenceEvent.enter},
      expiration: const Duration(days: 30),
      loiteringDelay: const Duration(minutes: 1),
      notificationResponsiveness: const Duration(seconds: 5),
    ),
  );

  await geo.NativeGeofenceManager.instance.createGeofence(
    geofence,
    _geofenceCallback,
  );

  await locCtrl.addLocation(
    StoredLocation(
      id: geofenceId,
      name: name.isNotEmpty ? name : '이름없음',
      latitude: latitude,
      longitude: longitude,
      radius: radiusValue,
    ),
  );
}
