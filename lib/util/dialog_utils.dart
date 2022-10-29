import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'constants.dart';

class DialogUtils {
  showLoadingDialog() {
    EasyLoading.show();
  }

  hideLoadingDialog() {
    EasyLoading.dismiss();
  }

  showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
    );
  }

  showMessage(BuildContext context, String message,
      {Color? backgroundColor, IconData? icon, double height = 56}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor ?? AppColors.secondary,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 153 - height),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      elevation: 0,
      duration: const Duration(seconds: 1),
      content: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(message),
              Icon(
                icon ?? Icons.check_circle_outline,
                color: Colors.white,
              ),
            ],
          )),
    ));
  }
}
