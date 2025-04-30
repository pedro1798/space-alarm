import 'package:native_geofence/native_geofence.dart';
import 'package:native_geofence/src/typedefs.dart';
import 'package:plata/models/location_repository.dart';
import 'package:plata/models/my_location.dart';

Future<void> initializeGeofence() async {
  await NativeGeofenceManager.instance.initialize();
}

Future<void> registerGeofence({
  required latitute,
  required longitute,
  required radius,
}) async {
  final double? latitude = double.tryParse(latitute);
  final double? longitude = double.tryParse(longitute);
  final double? radiusValue = double.tryParse(radius);
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
  final Location userLocation = Location(
    latitude: latitude,
    longitude: longitude,
  );

  final MyLocation myLocation = MyLocation(
    latitude: latitude,
    longitude: longitude,
  );

  final geofence = Geofence(
    // Geofence 객체 생성
    id: 'longitude: $longitude, latitude: $latitude',
    // id는 고유해야 하므로 위도와 경도를 조합하여 생성
    location: Location(latitude: latitude, longitude: longitude),
    radiusMeters: radiusValue,
    triggers: {GeofenceEvent.enter, GeofenceEvent.exit},
    iosSettings: IosGeofenceSettings(initialTrigger: true),
    androidSettings: AndroidGeofenceSettings(
      initialTriggers: {GeofenceEvent.enter},
      expiration: const Duration(days: 7),
      loiteringDelay: const Duration(minutes: 5),
      notificationResponsiveness: const Duration(minutes: 5),
    ),
  );

  await NativeGeofenceManager.instance.createGeofence(
    geofence,
    (GeofenceEvent event) {
          print('Geofence Event: $event');
        }
        as GeofenceCallback,
  );
  savedLocations.add(myLocation);
  print('지오펜스가 등록되었고 위치도 저장되었습니다.');
}
