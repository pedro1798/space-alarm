import 'package:flutter/material.dart';
import 'package:plata/pages/drawer/home_drawer.dart';
import 'package:plata/widgets/home/quick_alarm_dialog.dart';
import 'package:native_geofence/native_geofence.dart';
import 'package:native_geofence/src/typedefs.dart';
import 'package:plata/handers/geofence_register.dart' as geofenceRegister;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title}); // MyHomePage 생성자
  // super.key는 부모 클래스인 StatefulWidget의 생성자에 key를 전달하는 역할
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  // StatefulWidget이 처음 빌드될 때 자동으로 호출
}

class _MyHomePageState extends State<MyHomePage> {
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
    // final controller = Get.put(HomeController());
    // 필요하면 주석 해제

    return Scaffold(
      appBar: AppBar(
        // AppBar는 Material Design의 앱 바를 구현한 위젯입니다.
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // 가로로 늘려서 필드들이 동일한 너비를 갖도록 함
            children: <Widget>[
              TextField(
                controller: _latitudeController,
                decoration: InputDecoration(labelText: '위도'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 16), // 텍스트필드 사이 간격
              TextField(
                controller: _longitudeController,
                decoration: InputDecoration(labelText: '경도'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 16), // 텍스트필드 사이 간격
              TextField(
                controller: _radiusController,
                decoration: InputDecoration(labelText: '반경 (미터)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _registerGeofence,
                child: Text('지오펜스 등록'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // mini: true,
        shape: const CircleBorder(),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return QuickAlarmDialog();
            },
          );
        },
        child: const Icon(Icons.add), // add_circle_rounded 아이콘
      ),
      drawer: const HomeDrawer(), // home_drawer.dart
    );
  }
}
