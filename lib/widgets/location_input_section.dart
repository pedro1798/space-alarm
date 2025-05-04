import 'package:flutter/material.dart';
import 'package:plata/widgets/location_register_widget.dart';
import 'package:plata/utils/focus_hepler.dart';

// TextEditingController와 FocusNode 객체들 선언해서 location_register_widget.dart에 전달

class LocationInputSection extends StatefulWidget {
  const LocationInputSection({super.key, required this.focusHelperSetter});

  final void Function(FocusHelper helper) focusHelperSetter;

  @override
  State<LocationInputSection> createState() => _LocationInputSectionState();
}

class _LocationInputSectionState extends State<LocationInputSection> {
  late final TextEditingController _latitudeController;
  late final TextEditingController _longitudeController;
  late final TextEditingController _radiusController;
  late final TextEditingController _nameController;
  late final FocusNode _nameFocusNode;
  late final FocusNode _latFocusNode;
  late final FocusNode _longFocusNode;
  late final FocusNode _radFocusNode;
  late final FocusHelper _focusHelper;

  @override
  void initState() {
    super.initState();
    _latitudeController = TextEditingController();
    _longitudeController = TextEditingController();
    _radiusController = TextEditingController();
    _nameController = TextEditingController();

    _nameFocusNode = FocusNode();
    _latFocusNode = FocusNode();
    _longFocusNode = FocusNode();
    _radFocusNode = FocusNode();

    _focusHelper = FocusHelper([
      _nameFocusNode,
      _latFocusNode,
      _longFocusNode,
      _radFocusNode,
    ]);

    // 부모(MyHomePage)에게 전달
    widget.focusHelperSetter(_focusHelper);
  }

  @override
  Widget build(BuildContext context) {
    return LocationRegisterWidget(
      latController: _latitudeController,
      longController: _longitudeController,
      radController: _radiusController,
      nameController: _nameController,
      nameFocusNode: _nameFocusNode,
      latFocusNode: _latFocusNode,
      longFocusNode: _longFocusNode,
      radFocusNode: _radFocusNode,
    );
  }
}
