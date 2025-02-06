import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get screenWidth => MediaQuery.sizeOf(this).width;

  double get screenShortestSide => MediaQuery.sizeOf(this).shortestSide;
  double get screenLongestSide => MediaQuery.sizeOf(this).longestSide;

  double get statusBarPadding => MediaQuery.of(this).padding.top;

  double percentWidth(double percent) => screenWidth * percent / 100;
  double percentHeight(double percent) => screenHeight * percent / 100;
}
