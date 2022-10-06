import 'package:flutter/material.dart';
import 'package:modules_flutter/utils/colors_utils.dart';
import 'package:modules_flutter/utils/dimensions_utils.dart';

import 'base_text.dart';

class BaseMaterialButton extends MaterialButton {
  final VoidCallback onPressed;
  final String buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final double? borderRadius;
  final double? fontSize;
  final double? horizontalPadding;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;

  BaseMaterialButton(this.buttonText, this.onPressed,
      {super.key,
      this.buttonColor,
      this.textColor,
      this.fontSize,
      this.borderRadius,
      this.horizontalPadding,
      this.fontStyle,
      this.fontWeight})
      : super(
            child: BaseText(
              text: buttonText,
              color: textColor ?? Colors.white,
              fontSize: fontSize ?? dim20,
              fontStyle: fontStyle,
              fontWeight: fontWeight,
            ),
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? dim30),
            ),
            color: buttonColor ?? ColorsUtils.colorBase,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            elevation: 0,
            padding: EdgeInsets.symmetric(
                vertical: dim10, horizontal: horizontalPadding ?? dim40));
}

class BaseOutlinedButton extends OutlinedButton {
  final VoidCallback onPressed;
  final String buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;

  BaseOutlinedButton(this.buttonText, this.onPressed,
      {super.key,
      this.buttonColor,
      this.textColor,
      this.borderColor,
      this.borderRadius})
      : super(
          child: BaseText(text: buttonText, color: textColor ?? Colors.white),
          onPressed: onPressed,
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  side: BorderSide(
                      color: borderColor ?? Colors.blue,
                      width: dim10,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(borderRadius ?? dim30))),
              backgroundColor:
                  MaterialStateProperty.all(buttonColor ?? Colors.blue),
              elevation: MaterialStateProperty.all(0),
              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                  vertical: dim12, horizontal: dim40))),
        );
}
