import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plata/controllers/home_controller.dart';
import 'package:plata/pages/drawer/home_drawer.dart';
import 'package:plata/widgets/home/quick_alarm_dialog.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  /*
 	•	StatefulWidget 클래스 자체는 한 번 생성되면 변경되지 않는 불변 객체입니다.
	•	title 같은 필드는 초기 생성자에서 주입된 값이므로 변경되어선 안 됩니다.
	•	그래서 final을 붙여 “이건 한 번만 설정되며, 이후 절대 변하지 않음”을 보장합니다.
  */
  @override
  State<MyHomePage> createState() => _MyHomePageState();
  // StatefulWidget이 처음 빌드될 때 자동으로 호출
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

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
