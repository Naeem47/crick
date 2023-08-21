// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/routes.dart';
import 'package:tempalteflutter/constance/themes.dart';

class Dialogs {
  static void showDialogWithOneButton(
    BuildContext? context,
    String? title,
    String? content, {
    String? buttonLabel = "Okay",
    required VoidCallback? onButtonPress(),
    barrierDismissible = true,
  }) {
    showDialog(
      context: context!,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text(title!),
          content: Text(content!),
          actions: <Widget>[
            InkWell(
              child: Text(buttonLabel!),
              onTap: () => onButtonPress != null ? onButtonPress() : Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  static void showDialogWithTwoButtons(
    BuildContext? context,
    String? title,
    String? content, {
    String? button1Label = "Okay",
    VoidCallback? onButton1Press,
    String? button2Label = "Cancel",
    VoidCallback? onButton2Press,
    barrierDismissible = true,
  }) {
    showDialog(
      context: context!,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext buildContext) {
        return new AlertDialog(
          title: new Text(title!),
          content: new Text(content!),
          actions: <Widget>[
            new InkWell(
              child: new Text(button1Label!),
              onTap: () => onButton1Press != null ? onButton1Press() : Navigator.pop(context),
            ),
            new InkWell(
              child: new Text(button2Label!),
              onTap: () => onButton2Press != null ? onButton2Press() : Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  static void showDeadlineDialogWithOneButton(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return new AlertDialog(
          title: new Text(
            'The deadline has passed!',
          ),
          content: new Text(
            "Check out the contests you've joined for this match.",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: ConstanceData.SIZE_TITLE16,
            ),
          ),
          actions: <Widget>[
            new InkWell(
              child: new Text(
                "Ok",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  fontSize: ConstanceData.SIZE_TITLE18,
                ),
              ),
              onTap: () => Navigator.pop(context),
            )
          ],
        );
      },
    ).then((onValue) {
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.TAB, (Route<dynamic> route) => false);
    });
  }
}
