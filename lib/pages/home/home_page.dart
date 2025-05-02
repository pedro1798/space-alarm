import 'package:flutter/material.dart';
import 'package:plata/pages/drawer/home_drawer.dart';
import 'package:plata/widgets/home/quick_alarm_dialog.dart';
import 'package:plata/widgets/location_register_widget.dart';
import 'package:plata/handers/geofence_register.dart' as geofenceRegister;
import 'package:plata/widgets/location_list_widget.dart';

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
    geofenceRegister.initializeGeofence(); // Geofence 초기화
    // Geofence 초기화는 앱이 시작될 때 한 번만 호출되도록 initState에서 처리
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
      appBar: AppBar(
        // AppBar는 Material Design의 앱 바를 구현한 위젯입니다.
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      drawer: const HomeDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              // 위치 등록 위젯
              LocationRegisterWidget(
                latController: _latitudeController,
                longController: _longitudeController,
                radController: _radiusController,
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              const Text('저장된 위치 목록', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              // 리스트를 Expanded로 감싸서 남은 공간 모두 사용
              const Expanded(child: LocationListWidget()),
            ],
          ),
          // LocationRegisterWidget은 위치 등록을 위한 위젯입니다.
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
      ), // home_drawer.dart
    );
  }
}
