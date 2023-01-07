import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_stream/flutter_riverpod/main.dart';

class MyService {
  String baseUrl = "www.baidu.com";

  MyService() {
    print('MyService start...');
  }
}

class FakeRepository extends MyService {
  FakeRepository() {
    print('FakeRepository start...');
  }

  @override
  String get baseUrl => "www.google.com";
}

final repositoryProvider = Provider<MyService>((ref) {
  return MyService();
});

main() {
  testWidgets('Test example', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // override the behavior of repositoryProvider to provide a fake
          // implementation for test purposes.
          //重写 repositoryProvider 的行为，以提供用于测试目的的虚假实现
          repositoryProvider.overrideWithValue(FakeRepository()),
        ],
        child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget child) {
              MyService myService = ref.read(repositoryProvider);
              print('base url ${myService.baseUrl}');
              return child;
            },
            child: MyApp()),
      ),
    );
  });
}
