import 'package:flutter/material.dart';

class FocusHelper {
  final List<FocusNode> _focusNodes;

  FocusHelper(List<FocusNode> nodes) : _focusNodes = nodes;

  void unfocusAll() {
    for (final node in _focusNodes) {
      node.unfocus();
    }
  }

  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
  }
}
