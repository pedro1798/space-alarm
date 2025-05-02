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
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 내용에 맞게 크기 조절
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: latController,
              decoration: const InputDecoration(labelText: 'Latitude'),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: longController,
              decoration: const InputDecoration(labelText: 'Longitude'),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: radController,
              decoration: const InputDecoration(labelText: 'Radius (meters)'),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                await geofenceRegister.registerGeofence(
                  name: nameController.text,
                  lat: latController.text,
                  long: longController.text,
                  rad: radController.text,
                );
                nameController.clear();
                latController.clear();
                longController.clear();
                radController.clear();
              },
              icon: const Icon(Icons.add_location_alt),
              label: const Text('Register Geofence'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
