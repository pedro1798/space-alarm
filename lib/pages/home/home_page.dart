import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:plata/controllers/home_controller.dart';
import 'package:plata/pages/drawer/home_drawer.dart';
import 'package:plata/widgets/home/quick_alarm_dialog.dart';
import 'package:plata/themes/app_theme.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title}); // MyHomePage 생성자
  // super.key는 부모 클래스인 StatefulWidget의 생성자에 key를 전달하는 역할
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  // StatefulWidget이 처음 빌드될 때 자동으로 호출
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(HomeController());
    // 필요하면 주석 해제

    return Scaffold(
      appBar: AppBar(
        // AppBar는 Material Design의 앱 바를 구현한 위젯입니다.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              // 레이아웃 조절용 위젯. padding, margin, decoration 등 다양한 속성 제공
              width: MediaQuery.of(context).size.width * 0.6, // 반응형 너비 60%
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // 사각형 테두리를 가진 텍스트 필드
                  labelText: '목적지를 설정하세요', // 입력창 위에 보여질 라벨 텍스트
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // mini: true,
        shape: const CircleBorder(),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return QuickAlarmDialog();
            },
          );
        },
        child: const Icon(Icons.add), // add_circle_rounded 아이콘
      ),
      drawer: const HomeDrawer(), // home_drawer.dart
    );
  }
}
