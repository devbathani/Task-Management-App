import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_management_app/utils/color.dart';
import 'package:task_management_app/utils/text_styles.dart';

/// Curved grey container TextField
class CommonTextfield extends StatelessWidget {
  const CommonTextfield({
    super.key,
    this.focusNode,
    this.maxLength,
    this.enabled,
    this.height,
    this.suffix,
    this.prefix,
    this.onChanged,
    this.inputFormatters,
    this.textInputAction,
    this.controller,
    this.margin,
    this.onSubmitted,
    this.hintTextStyle,
    this.fillColor,
    this.textInputType,
    this.maxLines,
    this.validator,
    this.autoFocus,
    this.minLines,
    this.obscureText = false,
    this.style,
    this.contentPadding,
    this.hintText,
    this.textCapitalization = TextCapitalization.none,
  });
  final FocusNode? focusNode;
  final int? maxLength;
  final bool? enabled;
  final String? hintText;
  final double? height;
  final Widget? suffix;
  final Widget? prefix;
  final TextStyle? style;
  final bool? autoFocus;
  final int? minLines;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsets? margin;
  final Function(String value)? onSubmitted;
  final TextStyle? hintTextStyle;
  final Color? fillColor;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      maxLines: maxLines ?? 1,
      controller: controller,
      focusNode: focusNode,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      style: style ??
          subHeadingStyle.copyWith(
            fontSize: 16.sp,
            color: Color(0xff0F1A28),
          ),
      enabled: enabled ?? true,
      cursorColor: greenColor,
      minLines: minLines,
      autofocus: autoFocus ?? false,
      maxLength: maxLength,
      keyboardType: textInputType,
      onChanged: onChanged,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        prefixIcon: prefix,
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.r),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.r),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.r),
          borderSide: BorderSide(
            color: greenColor,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: hintText,
        hintStyle: hintTextStyle ??
            subHeadingStyle.copyWith(
              fontSize: 16.sp,
              color: Color(0xff0F1A28),
            ),
      ),
    );
  }
}
