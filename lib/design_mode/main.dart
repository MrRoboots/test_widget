import 'package:flutter/foundation.dart';
import 'package:test_stream/design_mode/chain_of_responsibility_mode/intercept_chain.dart';
import 'package:test_stream/design_mode/chain_of_responsibility_mode/intercept_chain_handler.dart';

import 'strategy_mode/business_action.dart';
import 'strategy_mode/io_strategy.dart';
import 'strategy_mode/net_strategy.dart';

///https://juejin.cn/post/6999875193082478600
main() {
  ///责任链模式
  var interceptChain = InterceptChainHandler<String>();
  interceptChain.add(OneIntercept());
  interceptChain.add(TwoIntercept());
  interceptChain.intercept('责任链模式');

  ///策略模式
  var type = 1;
  BusinessAction strategy;

  //不同业务使用不同策略
  if (type == 0) {
    strategy = NetStrategy();
  } else {
    strategy = IOStrategy();
  }

  //开始创建资源
  strategy.create();
  //......... 省略N多逻辑（其中某些场景，会有用到Net业务，和上面type是关联的）
  //IO业务：开始处理业务
  strategy.dealIO();
  //......... 省略N多逻辑
  //释放资源
  strategy.dispose();
}

class OneIntercept extends InterceptChain<String> {
  @override
  void intercept(data) {
    data = '$data OneIntercept';
    print(data);
    super.intercept(data);
  }
}

class TwoIntercept extends InterceptChain<String> {
  @override
  void intercept(data) {
    data = '$data TwoIntercept';
    print(data);
    super.intercept(data);
  }
}
