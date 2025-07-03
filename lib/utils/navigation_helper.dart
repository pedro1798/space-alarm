import 'package:flutter/material.dart';

/// 안전하게 포커스를 해제하고 현재 페이지를 팝
void safeNavigatePop(BuildContext context) {
  FocusScope.of(context).unfocus(); // 키보드 내리기
  Navigator.pop(context);
}

void safeNavigatePush({
  required BuildContext context,
  required Widget page,
  Duration delay = const Duration(milliseconds: 250),
}) {
  safeNavigatePop(context); // 현재 페이지 팝
  // 포커스 해제 후 딜레이를 주고 페이지 이동
  Future.delayed(delay, () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  });
}
