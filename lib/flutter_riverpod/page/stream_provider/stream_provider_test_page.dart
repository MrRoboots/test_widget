import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/io.dart';

final messageProvider = StreamProvider.autoDispose<String>((ref) async* {
  // Open the connection
  final channel = IOWebSocketChannel.connect('ws://10.10.5.70:7272');

  // Close the connection when the stream is destroyed
  ref.onDispose(() => channel.sink.close());

  // Parse the value received and emit a Message instance
  await for (final value in channel.stream) {
    yield value.toString();
  }
});

class StreamProviderTestPage extends ConsumerStatefulWidget {
  const StreamProviderTestPage({
    Key key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _StreamProviderTestPageState();
}

class _StreamProviderTestPageState extends ConsumerState<StreamProviderTestPage> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<String> message = ref.watch(messageProvider);
    return Scaffold(
        body: Center(
      child: message.when(
        loading: () => const CircularProgressIndicator(),
        error: (err, stack) => Text('Error: $err'),
        data: (message) {
          return Text(message);
        },
      ),
    ));
  }
}
