import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modules_flutter/utils/colors_utils.dart';
import 'package:modules_flutter/utils/dimensions_utils.dart';

class BaseTextField extends TextFormField {
  final String? initialValue;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final bool isSecure;
  final double? fontSize;
  final String? Function(String?)? validatorFun;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color borderColor;
  final Color? textColor;
  final Color? hintTextColor;
  final Widget? prefixIcon;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChange;
  final TextCapitalization textCapitalization;
  final BorderRadius? borderRadius;
  final double borderWidth;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final double? cursorHeight;
  final Color? cursorColor;
  final bool autoFocus;
  final bool readOnly;
  final bool isDense;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final bool? autoValidate;
  final String counterText;
  final BuildContext context;
  final String? labelText;

  BaseTextField(this.context,
      {this.initialValue,
      this.hintText,
      this.controller,
      this.textInputType,
      this.isSecure = false,
      this.fontSize,
      this.autoValidate,
      this.validatorFun,
      this.suffixIcon,
      this.fillColor,
      this.borderColor = ColorsUtils.colorBlack,
      this.textColor,
      this.hintTextColor,
      this.prefixIcon,
      this.onTap,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.onChange,
      this.textCapitalization = TextCapitalization.none,
      this.borderRadius,
      this.borderWidth = 0,
      this.maxLength,
      this.maxLines,
      this.minLines,
      this.enabled = true,
      this.cursorHeight,
      this.cursorColor,
      this.autoFocus = false,
      this.readOnly = false,
      this.isDense = false,
      this.contentPadding,
      this.textInputAction,
      this.focusNode,
      this.textAlign = TextAlign.start,
      this.inputFormatters,
      this.counterText = "",
      this.labelText})
      : super(
            initialValue: initialValue,
            enabled: enabled,
            controller: controller,
            keyboardType: textInputType,
            obscureText: isSecure,
            cursorHeight: cursorHeight,
            cursorColor: cursorColor ?? textColor ?? ColorsUtils.colorBlack,
            autofocus: autoFocus,
            readOnly: readOnly,
            maxLength: maxLength,
            // maxLines: maxLines,
            // minLines: minLines,
            style: TextStyle(
                fontSize: fontSize ?? dim15,
                fontWeight: FontWeight.normal,
                // height: 2,
                // fontFeatures: [FontFeature.subscripts()],
                color: textColor ?? ColorsUtils.colorBlack),
            onTap: onTap,
            onChanged: onChange,
            // autovalidate: autoValidate ?? false,
            //autovalidateMode: AutovalidateMode.onUserInteraction,
            // cursorHeight: 25,
            textAlignVertical: TextAlignVertical.center,
            textInputAction: textInputAction,
            textCapitalization: textCapitalization,
            onEditingComplete: onEditingComplete,
            onFieldSubmitted: onFieldSubmitted,
            inputFormatters: inputFormatters,
            focusNode: focusNode,
            textAlign: textAlign,
            //enableInteractiveSelection: false, //Stick cursor at end
            decoration: InputDecoration(
              labelText: labelText,
              errorMaxLines: 2,
              prefixIcon: prefixIcon,
              // prefixIconConstraints: BoxConstraints.tight(Size(36, 24)),
              fillColor: fillColor,
              filled: true,
              suffixIcon: suffixIcon,
              suffixIconConstraints: isDense
                  ? BoxConstraints(
                      minWidth: 2,
                      minHeight: 2,
                    )
                  : null,
              focusedBorder: OutlineInputBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(dim8),
                  borderSide:
                      BorderSide(color: borderColor, width: borderWidth)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(dim8),
                  borderSide:
                      BorderSide(color: borderColor, width: borderWidth)),
              border: OutlineInputBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(dim8),
                  borderSide:
                      BorderSide(color: borderColor, width: borderWidth)),
              contentPadding: contentPadding ??
                  EdgeInsets.symmetric(vertical: 0, horizontal: dim8),
              isDense: isDense,
              hintText: hintText,
              hintMaxLines: 1,
              hintStyle: TextStyle(
                  fontSize: fontSize ?? dim15,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0,
                  color: hintTextColor),
              counterText: counterText,
              //errorStyle: TextStyle(color: ColorsUtils.colorWhite)
            ),
            validator: validatorFun,
            autocorrect: false);
}
