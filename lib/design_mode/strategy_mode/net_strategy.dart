//Net策略
import 'business_action.dart';

class NetStrategy extends BusinessAction {
  @override
  void create() {
    print("创建Net资源");
  }

  @override
  void dealNet() {
    print("处理Net逻辑");
  }

  @override
  void dispose() {
    print("释放Net资源");
  }
}
