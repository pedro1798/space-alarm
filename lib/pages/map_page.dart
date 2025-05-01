import 'package:flutter/material.dart';
import 'package:plata/widgets/flutter_map_widget.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('map example')),
      body: Center(
        child: Padding(
          // padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
          padding: EdgeInsets.only(
            top: size.width * 0,
            left: 0,
            bottom: size.width * 0.4,
            right: 0,
          ),
          child: FlutterMapWidget(),
        ),
      ),
    );
  }
}
