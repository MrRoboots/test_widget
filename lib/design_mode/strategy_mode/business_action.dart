/// 结合适配器模式的接口适配：抽象必须实现行为，和可选实现行为
abstract class BusinessAction {
  ///创建相应资源：该行为必须实现
  void create();

  ///可选实现
  void dealIO() {}

  ///可选实现
  void dealNet() {}

  ///可选实现
  void dealSystem() {}

  ///释放资源：该行为必须实现
  void dispose();
}