import 'package:flutter/material.dart';
import 'package:todo_app/generated/l10n.dart';

import 'constants.dart';

class DialogUtils {
  BuildContext? _loadingContext;

  showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        _loadingContext = ctx;
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  hideLoadingDialog() {
    if (_loadingContext != null) {
      Navigator.of(_loadingContext!).pop();
      _loadingContext = null;
    }
  }

  showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.current.error),
        content: Text(message),
        actions: [
          TextButton(
            child: Text(S.current.ok),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
    );
  }

  showMessage(BuildContext context, String message,
      {Color? backgroundColor, IconData? icon, double height = 60}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height - height),
      content: Container(
          color: backgroundColor ?? AppColor.secondary,
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(message),
              Icon(icon ?? Icons.check_circle_outline),
            ],
          )),
    ));
  }
}
