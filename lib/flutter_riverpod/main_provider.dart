import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme/global_state.dart';

///计数器
final counterProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter(ref);
});

class Counter extends StateNotifier<int> {
  final Ref ref;

  Counter(this.ref) : super(0);

  void increment() {
    state++;
  }
}

///主题
final themeProvider = NotifierProvider<ThemeNotifier, AppState>(() {
  return ThemeNotifier();
});

class ThemeNotifier extends Notifier<AppState> {
  @override
  AppState build() {
    return const AppState();
  }

  void changeAppColor(MaterialColor color) {
    state = state.copyWith(themeColor: color);
  }

  void changeThemeMode(bool isDark) {
    state = state.copyWith(isDark: isDark);
  }
}
