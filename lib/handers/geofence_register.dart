import 'package:plata/models/my_location_repository.dart';
import 'package:native_geofence/native_geofence.dart' as geo;

// 초기화 (앱 시작 시 한 번만 호출해줘야 한다.)
Future<void> initializeGeofence() async {
  await geo.NativeGeofenceManager.instance.initialize();
}

/// 콜백 정의 (지오펜스에 진입/이탈 시 실행)
Future<void> _geofenceCallback(geo.GeofenceCallbackParams params) async {
  final event = params.event;
  final geo.Location? location = params.location;

  if (location == null) return;

  print('지오펜스 이벤트 발생: $event @ ${location.latitude}, ${location.longitude}');
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
  final double? latitude = double.tryParse(lat.toString());
  final double? longitude = double.tryParse(long.toString());
  final double? radiusValue = double.tryParse(rad.toString());

  // 위도 경도 유효성 검사
  if (latitude! < -90 ||
      latitude! > 90 ||
      longitude! < -180 ||
      longitude! > 180) {
    print('유효하지 않은 좌표입니다.');
    return;
  }
  /*
  _latitudeController.text
  _longitudeController.text
  _radiusController.text 
  로 입력 받으면 된다
  */

  if (latitude == null || longitude == null || radiusValue == null) {
    print('유효한 값을 입력하세요.');
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
  savedLocations.add(userLocation); // 위치 저장
  // print('지오펜스가 등록되었고 위치도 저장되었습니다.');
}
