import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AppColor {
  static const Color primary = Color(0xFFFF4F5A);
  static const Color secondary = Color(0xFF21A87D);
  static const Color background = Color(0xFFF6F6F6);
  static const Color title = Color(0xFF0C0C0C);
  static const Color hint = Color(0xFFB0B0B0);
}

class AppStyle {
  static const TextStyle title = TextStyle(
    fontSize: 16,
    color: AppColor.title,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    color: AppColor.title,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle hint = TextStyle(
    fontSize: 12,
    color: AppColor.hint,
    fontWeight: FontWeight.w500,
  );
}
