class StoredLocation {
  final String id;
  final double latitude;
  final double longitude;
  final double radius;
  final String name;

  StoredLocation({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.radius,
    this.name = '이름없음',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
      'name': name,
    };
  }

  factory StoredLocation.fromMap(Map<String, dynamic> map) {
    return StoredLocation(
      id: map['id'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      radius: map['radius'],
      name: map['name'] ?? '이름없음',
    );
  }
}
