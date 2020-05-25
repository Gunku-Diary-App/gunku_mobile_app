class SingletonStore {
  static final SingletonStore _singleton = SingletonStore._internal();

  factory SingletonStore() {
    return _singleton;
  }

  SingletonStore._internal();
}