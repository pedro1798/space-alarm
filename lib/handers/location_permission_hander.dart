import 'package:permission_handler/permission_handler.dart';

Future<void> requestLocationPermissions() async {
  final status = await Permission.locationAlways.status;

  if (!status.isGranted) {
    final result = await Permission.locationAlways.request();
    if (result.isGranted) {
      print('위치 권한 허용됨');
    } else {
      print('위치 권한 거부됨');
    }
  }
}
