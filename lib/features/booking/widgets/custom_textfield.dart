import 'package:car_rental/config/colors.dart';
import 'package:flutter/material.dart';

class CustomTextfield {
  static InputDecoration getDecoration({
    required BuildContext context,
    String? hintText,
    String? labelText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? onSuffixIconPressed,
    bool isPassword = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      filled: true,
      fillColor: isDark ? darkBgColor : lightBgColor,

      // Prefix Icon
      prefixIcon:
          prefixIcon != null
              ? Icon(
                prefixIcon,
                color: isDark ? darkLableColor : lightLableColor,
                size: 20,
              )
              : null,

      // Suffix Icon
      suffixIcon:
          suffixIcon != null
              ? IconButton(
                icon: Icon(
                  suffixIcon,
                  color: isDark ? darkLableColor : lightLableColor,
                  size: 20,
                ),
                onPressed: onSuffixIconPressed,
              )
              : null,

      // Content Padding
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      // Border Styles
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark ? darkDivColor : lightDivColor,
          width: 1.5,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark ? darkPrimaryColor : lightPrimaryColor,
          width: 2,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xffFF5252), width: 1.5),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xffFF5252), width: 2),
      ),

      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: (isDark ? darkLableColor : lightLableColor).withValues(
            alpha: .3,
          ),
          width: 1,
        ),
      ),

      // Text Styles
      labelStyle: TextStyle(
        fontFamily: "Poppins",
        fontSize: 14,
        color: isDark ? darkLableColor : lightLableColor,
        fontWeight: FontWeight.w500,
      ),

      hintStyle: TextStyle(
        fontFamily: "Poppins",
        fontSize: 14,
        color: (isDark ? darkLableColor : lightLableColor).withValues(
          alpha: .7,
        ),
        fontWeight: FontWeight.w400,
      ),

      errorStyle: const TextStyle(
        fontFamily: "Poppins",
        fontSize: 12,
        color: Color(0xffFF5252),
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
