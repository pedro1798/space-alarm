import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// FlutterLocalNotificationsPlugin의 인스턴스를 생성합니다.
// 이 인스턴스를 통해 로컬 알림을 설정하고 표시할 수 있습니다.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// 알림 시스템을 초기화하는 함수입니다.
/// 앱 시작 시 한 번 호출되어야 합니다.
Future<void> initNotification() async {
  // Android 플랫폼을 위한 초기화 설정입니다.
  // '@mipmap/ic_launcher'는 Android 알림에 사용될 아이콘을 지정합니다.
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // iOS 알림 초기화 설정: iOS 10 이상에서 알림 권한을 요청합니다.
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: true, // 알림 권한 요청
    requestBadgePermission: true, // 뱃지 권한 요청
    requestSoundPermission: true, // 소리 권한 요청
  );

  // 모든 플랫폼(Android, iOS 등)을 위한 초기화 설정을 통합합니다.
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  // 설정된 초기화 설정을 사용하여 FlutterLocalNotificationsPlugin을 초기화합니다.
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

/// 로컬 알림을 표시하는 함수입니다.
/// [title]은 알림의 제목, [body]는 알림의 내용을 나타냅니다.
/// [id]는 알림의 고유 ID로, 여러 알림을 구분하거나 업데이트/취소할 때 사용됩니다.
Future<void> showNotification(String title, String body, {int id = 0}) async {
  // Android 알림의 상세 설정을 정의합니다.
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'geofence_channel', // 알림 채널의 ID입니다.
        'Geofence Alerts', // 사용자에게 표시될 알림 채널의 이름입니다.
        channelDescription: '지오펜스 알림을 위한 채널',
        importance: Importance.max, // 알림의 중요도를 최대로 설정합니다.
        priority: Priority.high, // 알림의 우선순위를 높게 설정합니다.
        playSound: true, // 알림 시 소리를 재생할지 여부를 설정합니다.
      );

  // iOS ��림 상세 설정:
  // presentSound를 true로 설정하여 알림 시 소리가 나도록 합니다.
  const DarwinNotificationDetails iOSPlatformChannelSpecifics =
      DarwinNotificationDetails(
    presentSound: true,
  );

  // 플랫폼별 알림 상세 설정을 통합합니다.
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  // 설정된 상세 정보를 사용하여 알림을 표시합니다.
  // [id]는 알림의 고유 ID입니다.
  await flutterLocalNotificationsPlugin.show(
    id, // 알림 ID
    title, // 알림 제목
    body, // 알림 내용
    platformChannelSpecifics, // 플랫폼별 알림 상세 설정
  );
}