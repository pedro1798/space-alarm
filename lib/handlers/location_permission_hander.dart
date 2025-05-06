import 'package:permission_handler/permission_handler.dart';

Future<void> requestLocationPermissions() async {
  // 위치 권한이 이미 허용되었는지 확인
  PermissionStatus status = await Permission.location.request();

  if (status.isDenied) {
    // 권한이 거부되었을 경우
    print("위치 권한 거부됨");
  } else if (status.isGranted) {
    // 권한이 허용되었을 경우
    print("위치 권한 허용됨");
  } else if (status.isPermanentlyDenied) {
    // 권한이 영구적으로 거부되었을 경우
    print("위치 권한 영구적으로 거부됨");
    // openAppSettings(); // 앱 설정 화면으로 이동하여 수동으로 권한을 변경하도록 유도
  }
}
