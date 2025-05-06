import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

typedef MyValidator = String? Function(String?);

class CustomTextField extends StatelessWidget {
  final Color? borderColor;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLine;
  final TextEditingController? controller;
  final MyValidator? validator;
  TextInputType keyboardType;
  bool obscureText;
  String? obscuringCharacter;
  

  CustomTextField(
      {super.key, this.borderColor,
      this.hintText,
      this.hintStyle,
      this.prefixIcon,
      this.suffixIcon,
      this.labelText,
      this.labelStyle,
      this.maxLine,
      this.controller,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.obscuringCharacter});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter ?? "*",
      validator: validator,
      maxLines: maxLine ?? 1,
      controller: controller,
      cursorColor: AppColors.primaryLight,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              BorderSide(color: borderColor ?? AppColors.greyColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              BorderSide(color: borderColor ?? AppColors.greyColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              BorderSide(color: borderColor ?? AppColors.redColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              BorderSide(color: borderColor ?? AppColors.redColor, width: 1),
        ),
        hintText: hintText,
        hintStyle: hintStyle ?? AppStyles.medium16Grey,
        labelText: labelText,
        labelStyle: labelStyle ?? AppStyles.medium16Grey,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
