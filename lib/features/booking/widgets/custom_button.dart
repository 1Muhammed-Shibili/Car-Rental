import 'package:car_rental/config/colors.dart';
import 'package:flutter/material.dart';

class CustomButton {
  static ButtonStyle getPrimaryStyle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ElevatedButton.styleFrom(
      // Background Color
      backgroundColor: isDark ? darkPrimaryColor : lightPrimaryColor,
      foregroundColor: isDark ? darkBgColor : lightBgColor,

      // Disabled Colors
      disabledBackgroundColor: (isDark ? darkLableColor : lightLableColor)
          .withOpacity(0.3),
      disabledForegroundColor: (isDark ? darkFontColor : lightFontColor)
          .withOpacity(0.5),

      // Elevation
      elevation: 2,

      // Shape
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      // Padding
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

      // Text Style
      textStyle: const TextStyle(
        fontFamily: "Poppins",
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),

      // Animation Duration
      animationDuration: const Duration(milliseconds: 200),
    );
  }

  static ButtonStyle getSecondaryStyle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ElevatedButton.styleFrom(
      // Background Color
      backgroundColor: isDark ? darkDivColor : lightDivColor,
      foregroundColor: isDark ? darkFontColor : lightFontColor,

      // Disabled Colors
      disabledBackgroundColor: (isDark ? darkLableColor : lightLableColor)
          .withOpacity(0.2),
      disabledForegroundColor: (isDark ? darkFontColor : lightFontColor)
          .withOpacity(0.5),

      // Elevation
      elevation: 1,

      // Shape
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      // Padding
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

      // Text Style
      textStyle: const TextStyle(
        fontFamily: "Poppins",
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      ),

      // Animation Duration
      animationDuration: const Duration(milliseconds: 200),
    );
  }

  static ButtonStyle getOutlinedStyle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ElevatedButton.styleFrom(
      // Background Color
      backgroundColor: Colors.transparent,
      foregroundColor: isDark ? darkPrimaryColor : lightPrimaryColor,

      // Disabled Colors
      disabledBackgroundColor: Colors.transparent,
      disabledForegroundColor: (isDark ? darkLableColor : lightLableColor)
          .withOpacity(0.5),

      // Elevation
      elevation: 0,

      // Shape with Border
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark ? darkPrimaryColor : lightPrimaryColor,
          width: 1.5,
        ),
      ),

      // Padding
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

      // Text Style
      textStyle: const TextStyle(
        fontFamily: "Poppins",
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),

      // Animation Duration
      animationDuration: const Duration(milliseconds: 200),
    );
  }
}
