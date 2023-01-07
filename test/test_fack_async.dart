import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Future.timeout() throws an error once the timeout is up", () {
    // Any code run within [fakeAsync] is run within the context of the
    // [FakeAsync] object passed to the callback.
    fakeAsync((async) {
      // All asynchronous features that rely on timing are automatically
      // controlled by [fakeAsync].
      expect(Completer().future.timeout(const Duration(seconds: 5)), throwsA(isA<TimeoutException>()));

      // This will cause the timeout above to fire immediately, without waiting
      // 5 seconds of real time.
      async.elapse(const Duration(seconds: 5));
    });
  });
}
