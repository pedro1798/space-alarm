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
  final _nameFocusNode = FocusNode();
  final _latFocusNode = FocusNode();
  final _longFocusNode = FocusNode();
  final _radFocusNode = FocusNode();

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
    _nameController.dispose();

    _nameFocusNode.dispose();
    _latFocusNode.dispose();
    _longFocusNode.dispose();
    _radFocusNode.dispose();

    super.dispose();
  }

  void _unfocusAll() {
    _nameFocusNode.unfocus();
    _latFocusNode.unfocus();
    _longFocusNode.unfocus();
    _radFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // 키보드가 올라올 때 화면 크기 조정
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      drawer: const HomeDrawer(),
      onDrawerChanged: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _unfocusAll(); // 포커스 완전 제거
        });
      },
      body: GestureDetector(
        onTap: () => _unfocusAll(),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 16.0,
                ),
                child: Column(
                  children: [
                    LocationRegisterWidget(
                      latController: _latitudeController,
                      longController: _longitudeController,
                      radController: _radiusController,
                      nameController: _nameController,
                      nameFocusNode: _nameFocusNode,
                      latFocusNode: _latFocusNode,
                      longFocusNode: _longFocusNode,
                      radFocusNode: _radFocusNode,
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),
                    const Text('저장된 위치 목록', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    SizedBox(height: 300, child: const LocationListWidget()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _unfocusAll(); // 포커스 완전 제거
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
