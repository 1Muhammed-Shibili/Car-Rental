import 'package:car_rental/config/colors.dart';
import 'package:flutter/material.dart';

class CustomButton {
  static ButtonStyle getPrimaryStyle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ElevatedButton.styleFrom(
      backgroundColor: isDark ? darkPrimaryColor : lightPrimaryColor,
      foregroundColor: isDark ? darkBgColor : lightBgColor,

      disabledBackgroundColor: (isDark ? darkLableColor : lightLableColor)
          .withValues(alpha: .3),
      disabledForegroundColor: (isDark ? darkFontColor : lightFontColor)
          .withValues(alpha: .5),

      elevation: 2,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

      textStyle: const TextStyle(
        fontFamily: "Poppins",
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),

      animationDuration: const Duration(milliseconds: 200),
    );
  }

  static ButtonStyle getSecondaryStyle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ElevatedButton.styleFrom(
      backgroundColor: isDark ? darkDivColor : lightDivColor,
      foregroundColor: isDark ? darkFontColor : lightFontColor,

      disabledBackgroundColor: (isDark ? darkLableColor : lightLableColor)
          .withValues(alpha: .2),
      disabledForegroundColor: (isDark ? darkFontColor : lightFontColor)
          .withValues(alpha: .5),

      elevation: 1,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

      textStyle: const TextStyle(
        fontFamily: "Poppins",
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      ),

      animationDuration: const Duration(milliseconds: 200),
    );
  }

  static ButtonStyle getOutlinedStyle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: isDark ? darkPrimaryColor : lightPrimaryColor,

      disabledBackgroundColor: Colors.transparent,
      disabledForegroundColor: (isDark ? darkLableColor : lightLableColor)
          .withValues(alpha: .5),

      elevation: 0,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark ? darkPrimaryColor : lightPrimaryColor,
          width: 1.5,
        ),
      ),

      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

      textStyle: const TextStyle(
        fontFamily: "Poppins",
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),

      animationDuration: const Duration(milliseconds: 200),
    );
  }
}
