import 'package:flutter/material.dart';
import 'package:modules_flutter/base_classes/base_text_style.dart';
import 'package:modules_flutter/utils/colors_utils.dart';
import 'package:modules_flutter/utils/dimensions_utils.dart';

class BaseText extends Text {
  final String text;
  final Color color;
  final TextAlign textAlign;
  final double fontSize;
  final double letterSpacing;
  final TextOverflow? overflow;
  final TextDecoration textDecoration;
  final int? maxLines;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;

  BaseText(
      {super.key,
      required this.text,
      this.color = ColorsUtils.colorBlack,
      this.fontSize = dim16,
      this.textAlign = TextAlign.center,
      this.overflow,
      this.textDecoration = TextDecoration.none,
      this.maxLines,
      this.letterSpacing = 0.0,
      this.fontStyle,
      this.fontWeight,
      this.textStyle})
      : super(text,
            textScaleFactor: 0.80,
            textAlign: textAlign,
            overflow: overflow,
            maxLines: maxLines,
            style: textStyle ??
                BaseTextStyle(
                  decoration: textDecoration,
                  decorationStyle: TextDecorationStyle.solid,
                  color: color,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  fontStyle: fontStyle,
                  letterSpacing: letterSpacing,
                ));
}
