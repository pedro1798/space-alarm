import 'package:flutter/material.dart';
import 'package:plata/handers/geofence_register.dart' as geofenceRegister;

class LocationRegisterWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController latController;
  final TextEditingController longController;
  final TextEditingController radController;

  const LocationRegisterWidget({
    super.key,
    required this.nameController,
    required this.latController,
    required this.longController,
    required this.radController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
          CrossAxisAlignment.stretch, // 가로로 늘려서 필드들이 동일한 너비를 갖도록 함
      children: <Widget>[
        TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        const SizedBox(height: 16), // 텍스트필드 사이 간격
        TextField(
          controller: latController,
          decoration: const InputDecoration(labelText: 'Latitude'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: 16), // 텍스트필드 사이 간격
        TextField(
          controller: longController,
          decoration: const InputDecoration(labelText: 'Longitude'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: 16), // 텍스트필드 사이 간격
        TextField(
          controller: radController,
          decoration: const InputDecoration(labelText: 'Radius (meters)'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: 16), // 텍스트필드 사이 간격
        ElevatedButton(
          onPressed: () async {
            await geofenceRegister.registerGeofence(
              name: nameController.text,
              lat: latController.text,
              long: longController.text,
              rad: radController.text,
            );
          },
          child: const Text('register geofence'),
        ),
      ],
    );
  }
}
