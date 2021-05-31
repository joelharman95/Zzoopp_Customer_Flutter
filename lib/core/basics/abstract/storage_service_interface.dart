abstract class StorageServiceInterface {
  dynamic get(String key);
  Future<void> save<T>(String key, T content);
  Future<bool> delete(String key);
  bool exists(String key);
}
