import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> showAlertDialog(
    {required BuildContext context,
    Widget? title,
    required Widget content,
    List<Widget>? actions,
    Color? bg,
    bool outsideTouchDismiss = false,
    bool closeScreen = false}) {
  return showDialog(
    context: context,
    builder: (_) {
      return Platform.isAndroid
          ? androidAlertDialog(
              content: content, title: title, actions: actions, bg: bg)
          : iOSAlertDialog(content: content, title: title, actions: actions);
    },
    barrierDismissible: outsideTouchDismiss,
  ).then((value) {
    if (closeScreen) {
      Navigator.pop(context);
    }
    return value ?? false;
  });
}

//Android material dialog
Widget androidAlertDialog(
    {Widget? title,
    required Widget content,
    List<Widget>? actions,
    Color? bg}) {
  return AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    backgroundColor: bg,
    title: title,
    content: content,
    actions: actions,
  );
}

//iOS cupertino dialog
Widget iOSAlertDialog(
    {Widget? title, required Widget content, List<Widget>? actions}) {
  return CupertinoAlertDialog(
    title: title,
    content: content,
    actions: actions ?? [],
  );
}

//Custom alert dialog button
Widget customAlertButton(BuildContext context, String text,
    {Function? onTap,
    Color? btnColor,
    double verticalPadding = 10.0,
    double fontSize = 14.0,
    bool isClose = true,
    bool isOutline = false}) {
  return GestureDetector(
    onTap: () {
      if (onTap != null) {
        onTap();
      }
      if (isClose) Navigator.pop(context);
    },
    child: Container(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        width: double.infinity,
        decoration: isOutline
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(color: Colors.deepPurple))
            : BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: btnColor ?? Colors.deepPurple),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: isOutline ? Colors.deepPurple : Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: fontSize),
        )),
  );
}
