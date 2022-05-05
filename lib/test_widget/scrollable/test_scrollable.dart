///
/// 滚动组件
/// 第一个问题 android 上Scrollbar 无法拖动
/// 但使用ios CupertinoScrollbar 可以拖动
///
/// 第二个问题 在 ListView 数据量过大 卡顿问题？
/// 可以设置ListView itemExtent(每项Item的高度)解决
///
/// 三 可以设置ListView cacheExtent 缓存区大小 控制缓存的多少
///
/// 滚动相关组件
/// Dismissible 可以滑动删除组件
/// GradView
/// ListView
/// ListWheelScrollView 转轮效果 physics FixedExtentScrollPhysics:精确地停在某一个item上
/// RotatedBox 可以旋转任何组件
/// PageView 可以滑动切换组件
/// Scrollbar 滚动条
/// SingleChildScrollView 只有一个子组件的滚动组件
/// SliverAppBar 可以滚动的AppBar
/// SliverList 可以滚动的List
/// SliverGrid 可以滚动的Grid
/// NestedScrollView 嵌套滚动组件
/// ScrollConfiguration 可以设置滚动组件的滚动效果
/// ScrollPhysics 可以设置滚动组件的滚动效果
/// ReorderableListView 可以拖动排序的ListView

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TestScrollable(),
    );
  }
}

class TestScrollable extends StatefulWidget {
  const TestScrollable({Key key}) : super(key: key);

  @override
  State<TestScrollable> createState() => _TestScrollableState();
}

class _TestScrollableState extends State<TestScrollable> {
  @override
  Widget build(BuildContext context) {
    // return Container();
    return const Scaffold(
      body: TestListView(),
    );
  }
}

class TestListView extends StatefulWidget {
  const TestListView({Key key}) : super(key: key);

  @override
  State<TestListView> createState() => _TestListViewState();
}

class _TestListViewState extends State<TestListView> {
  final ScrollController _scrollController = ScrollController();
  int listCount = 0;
  final List<String> _list = List.generate(100, (index) => 'item $index');

  @override
  void initState() {
    listCount = _list.length;
    _scrollController.addListener(loadMore);
    super.initState();
  }

  loadMore() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _list.addAll(
            List.generate(10, (index) => 'item ${_list.length + index}'));
        listCount = _list.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 2));
      },
      child: CupertinoScrollbar(
        controller: _scrollController,
        isAlwaysShown: true,
        child: ListView.builder(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: _list.length + 1,
            itemExtent: 50,
            //确定每一项的高度
            // cacheExtent: 100, //缓存大小
            itemBuilder: (context, index) {
              if (index == listCount) {
                return loadMoreWidget();
              }
              return ListTile(
                title: Text('$index'),
              );
            }),
      ),
    );
  }

  Widget loadMoreWidget() {
    return const Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
