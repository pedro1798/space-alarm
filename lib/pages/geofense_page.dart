import 'package:flutter/material.dart';
import 'package:native_geofence/native_geofence.dart';
import 'package:native_geofence/src/typedefs.dart';

class GeofencePage extends StatefulWidget {
  @override
  _GeofencePageState createState() => _GeofencePageState();
}

class _GeofencePageState extends State<GeofencePage> {
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _radiusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeGeofence();
  }

  Future<void> _initializeGeofence() async {
    await NativeGeofenceManager.instance.initialize();
  }

  Future<void> _registerGeofence() async {
    final latitude = double.tryParse(_latitudeController.text);
    final longitude = double.tryParse(_longitudeController.text);
    final radius = double.tryParse(_radiusController.text);

    if (latitude == null || longitude == null || radius == null) {
      print('유효한 값을 입력하세요.');
      return;
    }

    final geofence = Geofence(
      id: 'custom_geofence',
      location: Location(latitude: latitude, longitude: longitude),
      radiusMeters: radius,
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
    print('지오펜스가 등록되었습니다.');
  }

  @override
  void dispose() {
    _latitudeController.dispose();
    _longitudeController.dispose();
    _radiusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Geofence Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _latitudeController,
              decoration: InputDecoration(labelText: '위도'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _longitudeController,
              decoration: InputDecoration(labelText: '경도'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _radiusController,
              decoration: InputDecoration(labelText: '반경 (미터)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerGeofence,
              child: Text('지오펜스 등록'),
            ),
          ],
        ),
      ),
    );
  }
}
