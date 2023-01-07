import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///consumer使用
///特点：适用于刷新单个小组件

final numberProvider = StateProvider((ref) => 0);

class ConsumerPage extends StatelessWidget {
  const ConsumerPage({Key key}) : super(key: key);
  static WidgetRef _ref;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget child) {
                _ref = ref;
                // This builder will only get called when the counterProvider
                // is updated.
                final count = ref.watch(numberProvider);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('$count'), //只刷新改变的值
                    child, //child 不进行刷新操作
                  ],
                );
              },
              // The child parameter is most helpful if the child is
              // expensive to build and does not depend on the value from
              // the notifier.
              child: const Text('Good job!'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.plus_one),
        onPressed: () {
          _ref?.read(numberProvider.notifier)?.state++;
        },
      ),
    );
  }
}
