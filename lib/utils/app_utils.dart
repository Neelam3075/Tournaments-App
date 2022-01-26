import 'dart:io';

import 'package:bluestack_demo/resources%20/app_colors.dart';
import 'package:bluestack_demo/resources%20/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUtils {
  static void showValidationDialog(BuildContext context, String message,
      {VoidCallback? okClicked, required String buttonText}) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text(buttonText,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )),
      style: ElevatedButton.styleFrom(
        primary: AppColors.primaryColor,
      ),
      onPressed: () {
        Navigator.pop(context);
        if (okClicked != null) {
          okClicked();
        }
      },
    );


    CupertinoAlertDialog cupertinoAlertDialog = CupertinoAlertDialog(
      title:  const Text(Strings.appName),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    AlertDialog alert = AlertDialog(
      insetPadding: const EdgeInsets.all(50),
      title: const Text(Strings.appName),
      content: Text(
        message,
        style: TextStyle(color: AppColors.black),
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (Platform.isAndroid) {
          return alert;
        } else {
          return cupertinoAlertDialog;
        }
      },
    );
  }
}
