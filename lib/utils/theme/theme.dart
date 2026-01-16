import 'package:flutter/material.dart';
import 'package:todo/utils/theme/widget_theme/appbar_theme.dart';
import 'package:todo/utils/theme/widget_theme/elevated_button.dart';
import 'package:todo/utils/theme/widget_theme/outlined_button.dart';
import 'package:todo/utils/theme/widget_theme/text_field.dart';
import 'package:todo/utils/theme/widget_theme/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    textTheme: AppTextTheme.lightTextTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
  );
}