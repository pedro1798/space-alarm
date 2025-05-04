import 'package:flutter/material.dart';
import 'package:plata/pages/drawer/home_drawer.dart';
import 'package:plata/widgets/home/quick_alarm_dialog.dart';
import 'package:plata/widgets/location_list_widget.dart';
import 'package:plata/widgets/location_input_section.dart';
import 'package:plata/handers/geofence_register.dart' as geofenceRegister;
import 'package:plata/utils/focus_hepler.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FocusHelper? _focusHelper;

  @override
  void initState() {
    super.initState();
    geofenceRegister.initializeGeofence();
  }

  void _unfocusAll() {
    _focusHelper?.unfocusAll();
  }

  @override
  void dispose() {
    _focusHelper?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      drawer: const HomeDrawer(),
      onDrawerChanged: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _unfocusAll();
        });
      },
      body: GestureDetector(
        onTap: _unfocusAll,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LocationInputSection(
                  focusHelperSetter: (helper) => _focusHelper = helper,
                  // focusHelperSetter 매개변수에 (helper) => _focusHelper = helper, 매개변수를 전달
                  // (helper) => _focusHelper = helper,는 람다식으로,
                  // LocationInputSection에서 생성한 FocusHelper 객체를 매개변수로 받아(helper) _focusHelper에 할당
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _unfocusAll();
          showDialog(
            context: context,
            builder: (context) => const QuickAlarmDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
