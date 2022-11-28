import 'business_action.dart';

///IO策略
class IOStrategy extends BusinessAction {
  @override
  void create() {
    print("创建IO资源");
  }

  @override
  void dealIO() {
    print("处理IO逻辑");
  }

  @override
  void dispose() {
    print("释放IO资源");
  }
}
