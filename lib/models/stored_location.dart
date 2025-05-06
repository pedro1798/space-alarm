import 'package:native_geofence/native_geofence.dart' as geo;

class StoredLocation {
  final String id;
  final double latitude;
  final double longitude;
  final double radius;
  final String name;
  final bool alarmEnabled; // ← 추가

  StoredLocation({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.radius,
    this.name = '이름없음',
    this.alarmEnabled = true, // ← 추가
  });

  geo.Geofence toGeofence() {
    return geo.Geofence(
      id: id,
      location: geo.Location(latitude: latitude, longitude: longitude),
      radiusMeters: radius,
      triggers: {geo.GeofenceEvent.enter, geo.GeofenceEvent.exit},
      iosSettings: geo.IosGeofenceSettings(initialTrigger: true),
      androidSettings: geo.AndroidGeofenceSettings(
        initialTriggers: {geo.GeofenceEvent.enter},
        expiration: const Duration(days: 7),
        loiteringDelay: const Duration(minutes: 5),
        notificationResponsiveness: const Duration(minutes: 5),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
      'name': name,
      'alarmEnabled': alarmEnabled ? 1 : 0, // 저장용
    };
  }

  factory StoredLocation.fromMap(Map<String, dynamic> map) {
    return StoredLocation(
      id: map['id'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      radius: map['radius'],
      name: map['name'] ?? '이름없음',
      alarmEnabled: map['alarmEnabled'] == 1, // SQLite의 INTEGER(1/0)
    );
  }

  StoredLocation copyWith({bool? alarmEnabled}) {
    return StoredLocation(
      id: id,
      latitude: latitude,
      longitude: longitude,
      radius: radius,
      name: name,
      alarmEnabled: alarmEnabled ?? this.alarmEnabled,
    );
  }
}
