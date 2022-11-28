/// 责任链模式

class InterceptChain<T> {
  InterceptChain next;

  void intercept(T data) {
    next?.intercept(data);
  }
}

