// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:plata/pages/drawer/home_drawer.dart';
import 'package:plata/widgets/home/quick_alarm_dialog.dart';
// import 'package:plata/controllers/theme_controller.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // setState()는 상태를 변경하고 UI를 다시 그리도록 Flutter에 알리는 메서드입니다.
      // setState로 감싸지 않으면 UI가 업데이트되지 않습니다.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
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
            Text(
              '+ 누른 횟수 $_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 8), // 버튼 사이 간격
          FloatingActionButton(
            // 설정 버튼 - add 버튼 분리하기
            mini: true,
            shape: const CircleBorder(),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return QuickAlarmDialog();
                },
              );
            },
            tooltip: '다른 동작',
            child: const Icon(Icons.add), // add_circle_rounded 아이콘
          ),
        ],
      ),
      drawer: const HomeDrawer(), // home_drawer.dart
    );
  }
}
