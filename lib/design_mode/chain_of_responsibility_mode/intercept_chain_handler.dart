import 'intercept_chain.dart';

class InterceptChainHandler<T> {
  InterceptChain _interceptChainFirst;

  void add(InterceptChain interceptChain) {
    if (_interceptChainFirst == null) {
      _interceptChainFirst = interceptChain;
      return;
    }

    assert(_interceptChainFirst != null);
    var node = _interceptChainFirst;
    while (true) {
      if (node.next == null) {
        node.next = interceptChain;
        break;
      }
      node = node.next;
    }
  }

  void intercept(T data) {
    _interceptChainFirst?.intercept(data);
  }
}
