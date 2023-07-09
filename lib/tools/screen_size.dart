import 'package:flutter/cupertino.dart';

class ScreenSize {
  static double get height => MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;

  static double get width => MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
}