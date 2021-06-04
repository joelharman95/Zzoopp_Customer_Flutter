import 'package:shared_preferences/shared_preferences.dart';
import 'package:zzoopp_customer/app/locator.config.dart';
import 'package:zzoopp_customer/core/basics/abstract/storage_service_interface.dart';

class SharedPreferencesStorageService implements StorageServiceInterface {
  SharedPreferences _preferences = locator<SharedPreferences>();

  Future<void> save<T>(String key, T content) async {
    if (content is String) {
      await _preferences.setString(key, content);
    }
    if (content is bool) {
      await _preferences.setBool(key, content);
    }
    if (content is int) {
      await _preferences.setInt(key, content);
    }
    if (content is double) {
      await _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      await _preferences.setStringList(key, content);
    }
  }

  dynamic get(String key) {
    var value = _preferences.get(key);
    return value;
  }

  List<String> getListOfString(String key) {
    return _preferences.getStringList(key);
  }

  Future<bool> delete(String key) {
    return _preferences.remove(key);
  }

  bool exists(String key) {
    return _preferences.containsKey(key);
  }
}
