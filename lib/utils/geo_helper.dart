import 'dart:math';
import 'package:latlong2/latlong.dart';

// 축척에 맞는 원형 구간을 생성하는 위젯
List<LatLng> createCirclePoints(
  LatLng center,
  double radiusInMeters,
  int points, // Number of points to create the circle
) {
  const earthRadius = 6378137.0;
  final List<LatLng> circlePoints = [];

  for (int i = 0; i < points; i++) {
    final angle = (i / points) * 2 * pi;
    final dx = radiusInMeters * cos(angle);
    final dy = radiusInMeters * sin(angle);

    final newLat = center.latitude + (180 / pi) * (dy / earthRadius);
    final newLng =
        center.longitude +
        (180 / pi) * (dx / (earthRadius * cos(pi * center.latitude / 180)));

    circlePoints.add(LatLng(newLat, newLng));
  }

  return circlePoints;
}
