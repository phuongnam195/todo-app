import 'package:flutter/cupertino.dart';

class AppColors {
  static const Color primary = Color(0xFFFF4F5A);
  static const Color secondary = Color(0xFF21A87D);
  static const Color background = Color(0xFFF6F6F6);
  static const Color title = Color(0xFF0C0C0C);
  static const Color hint = Color(0xFFB0B0B0);
  static const Color negative = Color(0xFF727272);
}

class AppStyle {
  static const TextStyle title = TextStyle(
    fontSize: 16,
    color: AppColors.title,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    color: AppColors.title,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle hintText = TextStyle(
    fontSize: 12,
    color: AppColors.hint,
    fontWeight: FontWeight.w500,
  );
}

const TASK_NOTIFICATION_BEFORE = Duration(minutes: 10);
