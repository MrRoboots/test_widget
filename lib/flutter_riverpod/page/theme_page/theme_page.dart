import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_stream/flutter_riverpod/main_provider.dart';
import 'package:test_stream/flutter_riverpod/theme/global_state.dart';

///
/// 主题
///
class ThemePage extends ConsumerStatefulWidget {
  const ThemePage({
    Key key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ThemePageState();
}

class _ThemePageState extends ConsumerState<ThemePage> {
  List<String> listTitle = [
    '主题色更改',
    '更改主题模式',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView.separated(
        itemBuilder: (context, index) => _buildListItem(index),
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemCount: listTitle.length);
  }

  Widget _buildListItem(int index) {
    return InkWell(
      onTap: () => _onTapItem(index),
      child: ListTile(title: Text(listTitle[index])),
    );
  }

  _onTapItem(int index) {
    ThemeNotifier themeNotifier = ref.read(themeProvider.notifier);
    AppState state = ref.read(themeProvider);
    switch (index) {
      case 0:
        themeNotifier.changeAppColor(Colors.red);
        break;
      case 1:
        themeNotifier.changeThemeMode(!state.isDark);
        break;
    }
  }
}
