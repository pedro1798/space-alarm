import 'package:flutter/material.dart';
import 'package:plata/handers/geofence_register.dart' as geofenceRegister;

class LocationRegisterWidget extends StatelessWidget {
  final TextEditingController latController;
  final TextEditingController longController;
  final TextEditingController radController;

  const LocationRegisterWidget({
    super.key,
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
          controller: latController,
          decoration: const InputDecoration(labelText: '위도'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: 16), // 텍스트필드 사이 간격
        TextField(
          controller: longController,
          decoration: const InputDecoration(labelText: '경도'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: 16), // 텍스트필드 사이 간격
        TextField(
          controller: radController,
          decoration: const InputDecoration(labelText: '반경 (미터)'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            await geofenceRegister.registerGeofence(
              lat: latController.text,
              long: longController.text,
              rad: radController.text,
            );
          },
          child: const Text('지오펜스 등록'),
        ),
      ],
    );
  }
}
