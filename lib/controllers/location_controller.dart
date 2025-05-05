// location_controller.dart
import 'package:get/get.dart';
import 'package:plata/models/stored_location.dart';
import 'package:plata/services/location_db.dart';

class LocationController extends GetxController {
  RxList<StoredLocation> locations = <StoredLocation>[].obs;

  // 로딩 여부 (선택적)
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadLocations();
  }

  void loadLocations() async {
    isLoading.value = true; // 로딩 시작
    final data = await LocationDatabase.getLocations();
    locations.value = data;
    isLoading.value = false; // 로딩 완료
  }

  Future<void> deleteLocation(String id) async {
    await LocationDatabase.deleteLocation(id);
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
}
