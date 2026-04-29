import 'package:flutter/material.dart';

class ScreenSizeConfig {
  final BuildContext context;
  late double screenWidth;
  late double screenHeight;

  ScreenSizeConfig(this.context) {
    _initScreenSize();
  }

  void _initScreenSize() {
    var screenSize = MediaQuery.of(context).size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
  }

  double getHeightPercentage(double percentage) {
    return screenHeight * (percentage / 100);
  }

  double getWidthPercentage(double percentage) {
    return screenWidth * (percentage / 100);
  }
}
