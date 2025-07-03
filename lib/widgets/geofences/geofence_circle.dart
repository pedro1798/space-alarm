// 📁 widgets/geofence_circle.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:plata/models/stored_location.dart';
import 'package:plata/utils/geo_helper.dart';

class GeofenceCircle {
  static Polygon fromLocation(StoredLocation location) {
    return Polygon(
      points: createCirclePoints(
        LatLng(location.latitude, location.longitude),
        location.radius,
        64,
      ),
      color: Colors.transparent,
      borderColor: Colors.blue,
      borderStrokeWidth: 2,
    );
  }
}
