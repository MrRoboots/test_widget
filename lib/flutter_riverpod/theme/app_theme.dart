import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'global_state.dart';

class AppTheme {
  ///白天statusBar配置
  static SystemUiOverlayStyle lightOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark);

  ///夜间statusBar配置
  static SystemUiOverlayStyle darkOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light);

  ///夜间模式
  static ThemeData darkTheme(AppState state) {
    return ThemeData(
      fontFamily: state.fontFamily,
      brightness: Brightness.dark,
      primaryColor: const Color(0xff4699FB),
      appBarTheme: AppBarTheme(systemOverlayStyle: darkOverlayStyle),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(foregroundColor: Colors.white, backgroundColor: Color(0xff4699FB)),
      dividerColor: Colors.white,
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(backgroundColor: Color(0xff181818), selectedItemColor: Color(0xff4699FB)),
      scaffoldBackgroundColor: const Color(0xff010201),
      useMaterial3: true,
    );
  }

  ///白天模式
  static ThemeData lightTheme(AppState state) {
    return ThemeData(
      fontFamily: state.fontFamily,
      primarySwatch: state.themeColor,
      useMaterial3: true,
      appBarTheme: AppBarTheme(systemOverlayStyle: lightOverlayStyle),
    );
  }

  ///白天/夜间模式切换
  static ThemeMode themeMode(AppState state) {
    return state.isDark ? ThemeMode.dark : ThemeMode.light;
  }
}
