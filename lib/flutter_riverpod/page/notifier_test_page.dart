import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = NotifierProvider<Counter, int>(() => Counter());

class Counter extends Notifier<int> {
  @override
  build() {
    return 0;
  }

  void add() {
    state++;
  }
}

class NotifierTestPage extends ConsumerWidget {
  const NotifierTestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int value = ref.watch(counterProvider);
    Counter counter = ref.read(counterProvider.notifier);
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
                onPressed: () {
                  counter.add();
                },
                child: const Text('Add')),
            Text('$value'),
          ],
        ),
      ),
    );
  }
}
