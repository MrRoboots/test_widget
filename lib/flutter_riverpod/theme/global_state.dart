import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

///
/// 说明: 全局状态类
///
class AppState extends Equatable {
  /// [fontFamily] 文字字体
  final String fontFamily;

  /// [themeColor] 主题色
  final MaterialColor themeColor;

  /// [showBackGround] 是否显示主页背景图
  final bool showBackGround;

  /// [codeStyleIndex] 代码样式 索引
  final int codeStyleIndex;

  /// [itemStyleIndex] 主页item样式 索引
  final int itemStyleIndex;

  /// [showPerformanceOverlay] 是否显示性能浮层
  final bool showPerformanceOverlay;

  /// [showOverlayTool] 是否显示浮动工具
  final bool showOverlayTool;

  /// [isDark] 是否夜间模式
  final bool isDark;

  const AppState({
    this.fontFamily = 'ComicNeue',
    this.themeColor = Colors.blue,
    this.showBackGround = true,
    this.codeStyleIndex = 0,
    this.itemStyleIndex = 0,
    this.showPerformanceOverlay = false,
    this.showOverlayTool = true,
    this.isDark = false,
  });

  @override
  List<Object> get props => [
        fontFamily,
        themeColor,
        showBackGround,
        codeStyleIndex,
        itemStyleIndex,
        showOverlayTool,
        showPerformanceOverlay,
        isDark,
      ];

  AppState copyWith({
    double height,
    String fontFamily,
    MaterialColor themeColor,
    bool showBackGround,
    int codeStyleIndex,
    int itemStyleIndex,
    bool showPerformanceOverlay,
    bool initialized,
    bool showOverlayTool,
    bool isDark,
  }) =>
      AppState(
        fontFamily: fontFamily ?? this.fontFamily,
        themeColor: themeColor ?? this.themeColor,
        showBackGround: showBackGround ?? this.showBackGround,
        codeStyleIndex: codeStyleIndex ?? this.codeStyleIndex,
        showOverlayTool: showOverlayTool ?? this.showOverlayTool,
        itemStyleIndex: itemStyleIndex ?? this.itemStyleIndex,
        showPerformanceOverlay: showPerformanceOverlay ?? this.showPerformanceOverlay,
        isDark: isDark ?? this.isDark,
      );

  @override
  String toString() {
    return 'AppState{fontFamily: $fontFamily, themeColor: $themeColor, showBackGround: $showBackGround, codeStyleIndex: $codeStyleIndex, itemStyleIndex: $itemStyleIndex, showPerformanceOverlay: $showPerformanceOverlay,isDark:$isDark}';
  }
}
