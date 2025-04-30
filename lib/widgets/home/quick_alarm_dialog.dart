import 'package:flutter/material.dart';

class QuickAlarmDialog extends StatelessWidget {
  const QuickAlarmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 16,
          bottom: 80,
          child: Material(
            color: const Color.fromARGB(0, 0, 0, 0),
            // 뾰족한 모서리 색(현재 투명)
            child: Container(
              width: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Text("빠른 알람 등록"),
            ),
          ),
        ),
      ],
    );
  }
}
