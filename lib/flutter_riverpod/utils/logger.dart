import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  ///每次在Provider更新时都会被调用
  @override
  void didUpdateProvider(ProviderBase provider, Object previousValue, Object newValue, ProviderContainer container) {
    print(
        'Logger didUpdateProvider provider:${provider.name ?? provider.runtimeType} previousValue(上一个值):$previousValue newValue(当前值):$newValue');
  }

  ///在每次销毁Provider的时候被调用
  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    print('Logger didDisposeProvider provider:${provider.name ?? provider.runtimeType}');
  }

  ///在每次初始化一个Provider时被调用
  @override
  void didAddProvider(ProviderBase provider, Object value, ProviderContainer container) {
    print('Logger didAddProvider ${provider.name ?? provider.runtimeType} value:$value');
  }
}
