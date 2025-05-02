class StoredLocation {
  final String id;
  final double latitude;
  final double longitude;
  final double radius;

  StoredLocation({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.radius,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
    };
  }

  factory StoredLocation.fromMap(Map<String, dynamic> map) {
    return StoredLocation(
      id: map['id'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      radius: map['radius'],
    );
  }
}
