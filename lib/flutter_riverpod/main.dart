import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_stream/flutter_riverpod/router/router_utils.dart';
import 'package:test_stream/flutter_riverpod/theme/global_state.dart';
import 'package:test_stream/flutter_riverpod/utils/logger.dart';

import 'main_provider.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(
    child: MyApp(),
    observers: [
      Logger(), //记录provider添加移除更新操作
    ],
  ));
}

class MyApp extends ConsumerWidget {
  MyApp({
    Key key,
  }) : super(key: key);

  final List<String> mWidgetList = [
    'consumerWidget使用',
    'consumerStatefulWidget使用',
    'consumer使用',
    'stateNotifierProvider使用',
    'streamProvider使用',
    'notifierProvider使用',
    '主题',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppState state = ref.watch(themeProvider);
    return DefaultTextStyle(
      style: TextStyle(fontFamily: state.fontFamily),
      child: MaterialApp(
        showPerformanceOverlay: state.showPerformanceOverlay,
        onGenerateRoute: RouterUtils.onGenerateRoute,
        debugShowCheckedModeBanner: false,
        themeMode: AppTheme.themeMode(state),
        darkTheme: AppTheme.darkTheme(state),
        theme: AppTheme.lightTheme(state),
        home: _buildHome(ref),
      ),
    );
  }

  Scaffold _buildHome(WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('river pod'),
        ),
        body: _buildListView());
  }

  ListView _buildListView() {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => _itemBuilder(context, index),
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemCount: mWidgetList.length);
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return InkWell(
      onTap: () => _onTapItem(context, index),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Text(mWidgetList[index]),
      ),
    );
  }

  void _onTapItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, RouterUtils.counterPage);
        break;
      case 1:
        Navigator.pushNamed(context, RouterUtils.consumerStatefulPage);
        break;
      case 2:
        Navigator.pushNamed(context, RouterUtils.consumerPage);
        break;
      case 3:
        Navigator.pushNamed(context, RouterUtils.stateNotifierProviderPage);
        break;
      case 4:
        Navigator.pushNamed(context, RouterUtils.streamProviderTestPage);
        break;
      case 5:
        Navigator.pushNamed(context, RouterUtils.notifierTestPage);
        break;
      case 6:
        Navigator.pushNamed(context, RouterUtils.themePage);
        break;
      case 7:

        /// ElevatedButton(
        ///   onTap: () {
        ///     final container = ProviderScope.containerOf(context);
        ///     showDialog(
        ///       context: context,
        ///       builder: (context) {
        ///         return ProviderScope(parent: container, child: MyModal());
        ///       },
        ///     );
        ///   },
        ///   child: Text('show modal'),
        /// )
        break;
    }
  }
}
