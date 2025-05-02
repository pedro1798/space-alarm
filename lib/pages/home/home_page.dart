import 'package:flutter/material.dart';
import 'package:plata/pages/drawer/home_drawer.dart';
import 'package:plata/widgets/home/quick_alarm_dialog.dart';
import 'package:plata/widgets/location_register_widget.dart';
import 'package:plata/handers/geofence_register.dart' as geofenceRegister;
import 'package:plata/widgets/location_list_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _radiusController = TextEditingController();
  final _nameController = TextEditingController(); // 이름 입력 필드 추가

  @override
  void initState() {
    super.initState();
    geofenceRegister.initializeGeofence();
  }

  @override
  void dispose() {
    _latitudeController.dispose();
    _longitudeController.dispose();
    _radiusController.dispose();
    _nameController.dispose(); // 이름 컨트롤러 dispose 추가
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      drawer: const HomeDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Column(
            children: [
              // 이름, 위도, 경도, 반경 입력 필드
              LocationRegisterWidget(
                latController: _latitudeController,
                longController: _longitudeController,
                radController: _radiusController,
                nameController: _nameController, // 이름 컨트롤러 전달
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              const Text('저장된 위치 목록', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              const Expanded(child: LocationListWidget()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return QuickAlarmDialog();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
