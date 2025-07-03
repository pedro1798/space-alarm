import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationTrackerController extends GetxController {
  final RxBool isTracking = false.obs;
  final Rx<Position?> currentPosition = Rx<Position?>(null);
  StreamSubscription<Position>? _positionStream;

  void startTracking() {
    if (isTracking.value) return;

    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position position) {
      currentPosition.value = position;
    });

    isTracking.value = true;
  }

  void stopTracking() {
    _positionStream?.cancel();
    _positionStream = null;
    isTracking.value = false;
  }

  @override
  void onClose() {
    stopTracking();
    super.onClose();
  }
}
