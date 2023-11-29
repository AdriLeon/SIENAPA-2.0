import 'package:flutter/material.dart';
class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
      extensions: <ThemeExtension<dynamic>>[
        CustomColors.light,
      ]
  );
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
      extensions: <ThemeExtension<dynamic>>[
        CustomColors.dark,
      ]
  );
}

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  final Color? appBarColor;
  final Color? backgroundColor;
  final Color? buttonColor;

  const CustomColors({
    this.appBarColor,
    this.backgroundColor,
    this.buttonColor,
  });

  @override
  ThemeExtension<CustomColors> copyWith({
    Color? appBarColor,
    Color? backgroundColor,
    Color? buttonColor,
  }) {
    return CustomColors(
      appBarColor: appBarColor ?? this.appBarColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      buttonColor: buttonColor ?? this.buttonColor,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      appBarColor: Color.lerp(appBarColor, other.appBarColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t),
    );
  }

  static const light = CustomColors(
    appBarColor: Color(0xFF518DC3),
    backgroundColor: Color(0xFFE5E5E5),
    buttonColor: Color(0xFF358E1D),
  );

  static const dark = CustomColors(
    appBarColor: Color(0xFF152B3E),
    backgroundColor: Color(0xFF4D4D4D),
    buttonColor: Color(0xFF1C570A),
  );
}