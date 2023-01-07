import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_stream/flutter_riverpod/main_provider.dart';

///ConsumerStatefulWidget 使用
///特点 ref全局都能使用
///ConsumerStatefulWidget继承自StatefulWidget
class ConsumerStatefulTestPage extends ConsumerStatefulWidget {
  const ConsumerStatefulTestPage({
    Key key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ConsumerStatefulTestPageState();
}

class _ConsumerStatefulTestPageState extends ConsumerState<ConsumerStatefulTestPage> {
  @override
  void initState() {
    super.initState();
    print('initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var counter = ref.watch(counterProvider);
    print('didChangeDependencies');
    // initState执行完成 会调用didChangeDependencies  会调用多次
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
    //父类刷新 子类会调用子类的didUpdateWidget  父类不会调用
    //如果子类用const修饰 子类的didUpdateWidget不会调用  父类也不会调用
  }

  @override
  Widget build(BuildContext context) {
    var counter = ref.watch(counterProvider);
    print('counter2:$counter');
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('ConsumerStatefulWidget使用特点:ref全局都能使用\nConsumerStatefulWidget继承自StatefulWidget'),
            const SizedBox(height: 16),
            Text('计数器：$counter'),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        ref.read(counterProvider.notifier).increment();
      },
      child: const Icon(Icons.add),
    );
  }
}
