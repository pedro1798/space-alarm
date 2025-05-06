// location_controller.dart
import 'package:get/get.dart';
import 'package:plata/models/stored_location.dart';
import 'package:plata/services/location_db.dart';
import 'package:native_geofence/native_geofence.dart' as geo;

class LocationController extends GetxController {
  RxList<StoredLocation> locations = <StoredLocation>[].obs;

  // 로딩 여부 (선택적)
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadLocations();
  }

  /// 외부에서 사용할 수 있는 안전한 fetch 메서드
  Future<List<StoredLocation>> getLocations() async {
    return locations.toList(); // 현재 메모리에 있는 데이터 제공
  }

  /// 내부적으로 DB에서 데이터를 로드
  void loadLocations() async {
    isLoading.value = true; // 로딩 시작
    final data = await LocationDatabase.getLocations();
    locations.value = data;
    isLoading.value = false; // 로딩 완료
  }

  Future<void> deleteLocation(geo.Geofence location) async {
    try {
      // native geofence 삭제
      await geo.NativeGeofenceManager.instance.removeGeofence(location);
    } catch (e) {
      Get.snackbar(
        '삭제 실패',
        '지오펜스 삭제에 실패했습니다: $e',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
      return;
    }
    // DB에서 삭제
    await LocationDatabase.deleteLocation(location.id);
    // 삭제 후 로드
    loadLocations();
    Get.snackbar(
      '지오펜스 삭제',
      '지오펜스가 삭제되었습니다.',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  Future<void> addLocation(StoredLocation loc) async {
    await LocationDatabase.insertLocation(loc);
    // 추가 후 로드
    loadLocations();
    Get.snackbar(
      '지오펜스 등록',
      '지오펜스가 등록되었고 위치도 저장되었습니다.',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  Rx<StoredLocation?> selectedLocation = Rx<StoredLocation?>(null);

  void selectLocation(StoredLocation location) {
    selectedLocation.value = location;
  }

  Future<void> toggleAlarm(String id, bool enabled) async {
    final db = await LocationDatabase.database;
    await db.update(
      'locations',
      {'alarmEnabled': enabled ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
    loadLocations(); // 다시 로드
  }
}
