import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_stream/flutter_riverpod/main_provider.dart';
import 'package:test_stream/flutter_riverpod/widget/wx_zoom_image/zoom_image.dart';

///ConsumerWidget 使用
///特点：ref局部使用(build中)
///ConsumerWidget 继承自ConsumerStatefulWidget
class ConsumerWidgetTestPage extends ConsumerWidget {
  const ConsumerWidgetTestPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var counter = ref.watch(counterProvider);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        /* child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('ConsumerWidget 使用特点：ref局部使用(build中)\nConsumerWidget 继承自ConsumerStatefulWidget'),
            const SizedBox(height: 16),
            Text('计数器：$counter'),
            const ZoomImage(),
          ],
        ),*/
        child: const ZoomImage(),
      ),
      floatingActionButton: _buildFloatingActionButton(ref),
    );
  }

  FloatingActionButton _buildFloatingActionButton(WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () => ref.read(counterProvider.notifier).increment(),
      child: const Icon(Icons.add),
    );
  }
}
