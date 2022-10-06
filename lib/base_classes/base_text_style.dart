import 'package:flutter/material.dart';

class BaseTextStyle extends TextStyle {
  bool inheritValue;
  final Color? color;
  final Color? backgroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextBaseline? textBaseline;
  final double? height;
  final leadingDistribution;
  final Locale? locale;
  final Paint? foreground;
  final Paint? background;
  final shadows;
  final fontFeatures;
  final fontVariations;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final String? debugLabel;
  final TextOverflow? overflow;
  String? fontFamily;
  List<String>? fontFamilyFallback;
  String? package;

  BaseTextStyle(
      {this.inheritValue = false,
      this.color,
      this.backgroundColor,
      this.fontSize,
      this.fontWeight,
      this.fontStyle,
      this.letterSpacing,
      this.wordSpacing,
      this.textBaseline,
      this.height,
      this.leadingDistribution,
      this.locale,
      this.foreground,
      this.background,
      this.shadows,
      this.fontFeatures,
      this.fontVariations,
      this.decoration,
      this.decorationColor,
      this.decorationStyle,
      this.decorationThickness,
      this.debugLabel,
      this.fontFamily,
      this.fontFamilyFallback,
      this.package,
      this.overflow})
      : super(
            inherit: inheritValue,
            color: color,
            backgroundColor: backgroundColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
            textBaseline: textBaseline,
            height: height,
            leadingDistribution: leadingDistribution,
            locale: locale,
            foreground: foreground,
            background: background,
            shadows: shadows,
            fontFeatures: fontFeatures,
            fontVariations: fontVariations,
            decoration: decoration,
            decorationColor: decorationColor,
            decorationStyle: decorationStyle,
            decorationThickness: decorationThickness,
            debugLabel: debugLabel,
            fontFamily: fontFamily,
            fontFamilyFallback: fontFamilyFallback,
            package: package,
            overflow: overflow);
}
