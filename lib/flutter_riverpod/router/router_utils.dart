import 'package:flutter/material.dart';
import 'package:test_stream/flutter_riverpod/page/consumer_page.dart';
import 'package:test_stream/flutter_riverpod/page/consumer_stateful_test_page.dart';
import 'package:test_stream/flutter_riverpod/page/consumer_widget_test_page.dart';
import 'package:test_stream/flutter_riverpod/page/notifier_test_page.dart';
import 'package:test_stream/flutter_riverpod/page/state_norifier_provider_page/state_notifier_provider_test_page.dart';
import 'package:test_stream/flutter_riverpod/page/stream_provider/stream_provider_test_page.dart';
import 'package:test_stream/flutter_riverpod/page/theme_page/theme_page.dart';
import 'package:test_stream/flutter_riverpod/router/router_anim.dart';

class RouterUtils {
  static const String counterPage = 'counterPage';
  static const String consumerStatefulPage = 'consumerStatefulPage';
  static const String consumerPage = 'consumerPage';
  static const String stateNotifierProviderPage = 'stateNotifierProviderPage';
  static const String streamProviderTestPage = 'streamProviderTestPage';
  static const String notifierTestPage = 'notifierTestPage';
  static const String themePage = 'themePage';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print('routerUtils name:${settings.name} arguments:${settings.arguments}');
    switch (settings.name) {
      case counterPage:
        return Right2LeftRouter(child: const ConsumerWidgetTestPage());
      case consumerStatefulPage:
        return Right2LeftRouter(child: const ConsumerStatefulTestPage());
      case consumerPage:
        return Right2LeftRouter(child: const ConsumerPage());
      case stateNotifierProviderPage:
        return Right2LeftRouter(child: const StateNotifierProviderTestPage());
      case streamProviderTestPage:
        return Right2LeftRouter(child: const StreamProviderTestPage());
      case notifierTestPage:
        return Right2LeftRouter(child: const NotifierTestPage());
      case themePage:
        return Right2LeftRouter(child: const ThemePage());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text('no router ${settings.name}'),
                  ),
                ));
    }
  }
}
