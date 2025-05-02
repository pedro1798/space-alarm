/*
import 'package:native_geofence/native_geofence.dart' as geo;
// import 'package:plata/services/location_db.dart';
import 'package:plata/models/stored_location.dart';
import 'package:get/get.dart';
import 'package:plata/controllers/location_controller.dart';

// 초기화 (앱 시작 시 한 번만 호출해줘야 한다.)
Future<void> initializeGeofence() async {
  await geo.NativeGeofenceManager.instance.initialize();
}

/// 콜백 정의 (지오펜스에 진입/이탈 시 실행)
Future<void> _geofenceCallback(geo.GeofenceCallbackParams params) async {
  final event = params.event;
  final geo.Location? location = params.location;

  if (location == null) return;

  Get.snackbar(
    '지오펜스 이벤트 발생',
    '$event @ ${location.latitude}, ${location.loㅃngitude}',
    snackPosition: SnackPosition.BOTTOM,
    duration: Duration(seconds: 2),
  );
  return;

  /*
  실제 앱에서는 여기에 알림 전송/DB 업데이트 등의 로직 추가
  if (event == GeofenceEvent.enter) {
    _sendNotification('지정 영역에 진입했습니다!');
  } else {
    _sendNotification('지정 영역을 벗어났습니다!');
  }
  _sendNotification은 알림을 보내는 함수로, 실제 구현 필요
  */
}

Future<void> registerGeofence({
  required lat,
  required long,
  required rad,
}) async {
  final LocationController locCtrl = Get.find<LocationController>();
  final double? latitude = double.tryParse(lat.toString());
  final double? longitude = double.tryParse(long.toString());
  final double? radiusValue = double.tryParse(rad.toString());

  // 위도 경도 유효성 검사
  if (latitude! < -90 ||
      latitude! > 90 ||
      longitude! < -180 ||
      longitude! > 180) {
    Get.snackbar(
      '잘못된 입력',
      '유효하지 않는 위도/경도입니다.',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
    return;
  }

  if (latitude == null || longitude == null || radiusValue == null) {
    Get.snackbar(
      '잘못된 입력',
      '입력란에 공백이 있습니다.',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
    return;
  }
  final geo.Location userLocation = geo.Location(
    latitude: latitude!, // Null Safety 명시때문에 ! 사용
    longitude: longitude!, // Null Safety 명시때문에 ! 사용
  );

  final geofence = geo.Geofence(
    // Geofence 객체 생성
    id: 'geofence_${DateTime.now().millisecondsSinceEpoch}', // 고유 ID
    location: userLocation,
    radiusMeters: radiusValue!, // Null Safety 명시때문에 ! 사용
    triggers: {geo.GeofenceEvent.enter, geo.GeofenceEvent.exit}, // 패키지 enum
    iosSettings: geo.IosGeofenceSettings(initialTrigger: true),
    androidSettings: geo.AndroidGeofenceSettings(
      initialTriggers: {geo.GeofenceEvent.enter},
      expiration: const Duration(days: 7),
      loiteringDelay: const Duration(minutes: 5),
      notificationResponsiveness: const Duration(minutes: 5),
    ),
  );

  await geo.NativeGeofenceManager.instance.createGeofence(
    geofence,
    _geofenceCallback,
  );
  // savedLocations.add(userLocation); // 위치 저장
  await locCtrl.addLocation(
    StoredLocation(
      id: geofence.id,
      latitude: latitude,
      longitude: longitude,
      radius: radiusValue,
    ),
  );
}

*/

import 'package:native_geofence/native_geofence.dart' as geo;
import 'package:plata/models/stored_location.dart';
import 'package:get/get.dart';
import 'package:plata/controllers/location_controller.dart';

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
      expiration: const Duration(days: 7),
      loiteringDelay: const Duration(minutes: 5),
      notificationResponsiveness: const Duration(minutes: 5),
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
