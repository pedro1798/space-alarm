class MyLocation {
  final double latitude;
  final double longitude;

  const MyLocation({required this.latitude, required this.longitude});

  // Jsone 직렬화
  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude};
  }

  factory MyLocation.fromJson(Map<String, dynamic> json) => MyLocation(
    latitude: json['latitude'] as double,
    longitude: json['longitude'] as double,
  );
}
